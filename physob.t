% a physical object at a point with mass and velocity
class PhysOb
  import WRAP,BOUNCE,CLIP,Configuration,vector, vector_add, vector_copy, vector_distance,vector_bearing, vector_str, vector_scalar_multiply
  export initialize,getName,draw,step,isMoving,gravity_force,getPosition,getMass,getDistance,force_reset, force_add

  deferred procedure draw

  var name: string
  var position: vector
  var mass: int:=100 % grams
  var radius: int :=20  % pixels
  var mycolour:int := red

  var velocity: vector
  var forces: vector

  var debug:boolean:=false
  var config: pointer to Configuration
  var msec_since_last_sample: int := 0

  var history: flexible array 0..1000 of vector
  var history_count: int :=0

  proc initialize(config_: pointer to Configuration, name_ :string, mass_, radius_, colour_: int, x_, y_, vx_, vy_: real)
    name:=name_
    mass:=mass_
    radius:=radius_
    mycolour:=colour_
    position.x:=x_
    position.y:=y_
    velocity.x:=vx_
    velocity.y:=vy_
    config:=config_
  end initialize
  
  function getName() : string
    result name
  end getName
  
  function getPosition: vector
    result position
  end getPosition
  
  function getMass(): int
    result mass
  end getMass
  
  function isMoving () : boolean
    result velocity.x > .01 or velocity.x < -.01 or velocity.y > .01 or velocity.y < -.01
  end isMoving

  function getDistance(o: pointer to PhysOb): real
    result vector_distance(position, o->getPosition)
  end getDistance
 
  function getBearing(o: pointer to PhysOb): real
    result vector_bearing(position, o-> getPosition)
  end getBearing
  
  function gravity_force(o: pointer to PhysOb): vector
    var v:vector
    var f:real := config -> G * mass * o-> getMass() / getDistance(o)**2
    var theta: real := getBearing(o)
    v.x:=sin(theta)*f
    v.y:=cos(theta)*f
    if debug then
      put "(", name, " -> " , o->getName(), ") F scalar " , f
      put "(", name, " -> " , o->getName(), ") Theta=", theta,  " sin=", sin(theta), " cos=", cos(theta)
      put "F " , vector_str(v)
    end if
    result v
  end gravity_force

  proc force_reset()
    forces.x:=0
    forces.y:=0
  end force_reset

  proc force_add(v:vector)
    forces.x := forces.x + v.x
    forces.y := forces.y + v.y
  end force_add

  proc doGeometry
    if config -> geometry = WRAP then
      if position.x  < 0 then
	position.x := maxx
      elsif position.x  > maxx then
	position.x := 0
      end if
      if position.y  < 0 then
	position.y := maxy 
      elsif position.y  > maxy then
	position.y := 0
      end if
    elsif config -> geometry = BOUNCE then
      % collision with walls.  Walls have infinite mass and collision is almost elastic
       if position.y - radius < 5 or position.y + radius + 5 > maxy then
	 velocity.y:=-velocity.y*config -> collision_recoil
       end if
       if position.x -radius < 5 or position.x + radius + 5 > maxx then
	 velocity.x:=-velocity.x*config -> collision_recoil
       end if
    elsif config -> geometry = CLIP then
      % just let it go offscreen.  We could delete it, as it will (most likely) never come bacl
    end if
  end doGeometry

  proc doFloorGravity(seconds:real)
    % In reality gravity does not stop at the floor, rather it should be 
    % balanced by an upward force exterted by the floor
    if position.y - radius > 2 then
      velocity.y := velocity.y + (-100 / mass) * seconds
    end if
  end doFloorGravity

  proc draw_relative_vector(v: vector, c: int)
    drawline(floor(position.x), floor(position.y),		floor(position.x + v.x), floor(position.y + v.y), c)
  end draw_relative_vector

  proc sample_position
    history_count := history_count + 1
    history(history_count-1) := vector_copy(position)
  end sample_position

  proc step (seconds: real)
    if config -> floor_gravity then
      doFloorGravity(seconds)
    end if

    % acceleration = force /mass
	var acceleration: vector := vector_scalar_multiply(forces, 1/mass)

    % delta_v (change in velocity) =  acceleration * time
    var delta_v : vector:= vector_scalar_multiply(acceleration, seconds)
    velocity := vector_add(velocity,delta_v)

 	% change in position = velocity * time
	position := vector_add(position, vector_scalar_multiply(velocity, seconds))

    if config -> history_sample_period_msec > 0 then
      msec_since_last_sample := 	msec_since_last_sample + floor(seconds * 1000)
      if history_count = 0 or msec_since_last_sample > config -> history_sample_period_msec then
        sample_position
        msec_since_last_sample := 0
      end if
    end if

    doGeometry
 
  end step


end PhysOb

