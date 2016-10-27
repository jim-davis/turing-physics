var WRAP:string:="wrap"
var BOUNCE:string:="bounce"
var CLIP:string:="clip"

var geometry:string:=WRAP
var floor_gravity: boolean:=false

% a physical object at a point with mass and velocity
class PhysOb
  import geometry,WRAP,BOUNCE,CLIP,floor_gravity,vector,vector_distance,vector_bearing
  export initialize,draw,step,isMoving,gravity_force,getPosition,getMass,getRadius,getDistance,force_reset, force_add

  deferred procedure draw
  deferred procedure hide

  var position: vector
  var mass: int:=100 % grams
  var radius: int :=20  % pixels
  var mycolour:int := red

  var velocity: vector
  var forces: vector

  var collision_recoil:real:=1  % "energy" retained after collision with wall.  1 means elastic
  var G: real := .1  % gravitational constant

  proc initialize(mass_, radius_, colour_: int, x_, y_, vx_, vy_: real)
    mass:=mass_
    radius:=radius_
    mycolour:=colour_
    position.x:=x_
    position.y:=y_
    velocity.x:=vx_
    velocity.y:=vy_
  end initialize
  
  function getX() : real
    result position.x
  end getX
  
  function getY(): real
    result position.y
  end getY

  function getPosition: vector
    result position
  end getPosition
  
  function getRadius() : real
    result radius
  end getRadius

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
    var f:real := G * mass * o-> getMass() / getDistance(o)**2
    %put "F scalar " + realstr(f,4)
    var theta: real := getBearing(o)
    %put "Theta=" + realstr(theta,2) + " sin=" + realstr(sin(theta),2) + " cos=" + realstr(cos(theta),2)
    v.x:=sin(theta)*f
    v.y:=cos(theta)*f
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
    if geometry = WRAP then
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
    elsif geometry = BOUNCE then
      % collision with walls.  Walls have infinite mass and collision is almost elastic
       if position.y - radius < 5 or position.y + radius + 5 > maxy then
	     velocity.y:=-velocity.y*collision_recoil
       end if
       if position.x -radius < 5 or position.x + radius + 5 > maxx then
	 velocity.x:=-velocity.x*collision_recoil
       end if
    elsif geometry = CLIP then
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
      drawline(floor(position.x), floor(position.y), 
		   floor(position.x + v.x), floor(position.y + v.y), c)
  end draw_relative_vector

  proc step (seconds: real)
    if floor_gravity then
      doFloorGravity(seconds)
    end if

	% acceleration (change in velocity) = force /mass
    % change in velocity =  acceleration * time
    velocity.x := velocity.x + forces.x * seconds / mass
    velocity.y := velocity.y + forces.y * seconds / mass

    draw_relative_vector(forces, red)
	draw_relative_vector(velocity, blue)

    position.x := position.x + velocity.x * seconds
    position.y := position.y + velocity.y * seconds
    doGeometry
 
  end step

end PhysOb

