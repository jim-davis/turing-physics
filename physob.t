var WRAP:string:="wrap"
var BOUNCE:string:="bounce"
var CLIP:string:="clip"

var geometry:string:=WRAP
var floor_gravity: boolean:=false

% a physical object at a point with mass and velocity
class PhysOb
  import geometry,WRAP,BOUNCE,CLIP,floor_gravity,vector
  export initialize,draw,hide,step,isMoving,gravity_force,getX,getY,getMass,getRadius,getDistance,force_reset, force_add

  deferred procedure draw
  deferred procedure hide

  var x,y:real:=0
  var mass: int:=100 % grams
  var radius: int :=20  % pixels
  var vx,vy: real  :=0 % pixels/second
  var mycolour:int := red
  var collision_recoil:real:=1
  var G: real := 1  % gravitational constant
  var forces: vector

  proc initialize(mass_, radius_, colour_: int, x_, y_, vx_, vy_: real)
    mass:=mass_
    radius:=radius_
    mycolour:=colour_
    x:=x_
    y:=y_
    vx:=vx_
    vy:=vy_
  end initialize
  
  function getX() : real
    result x
  end getX
  
  function getY(): real
    result y
  end getY
  
  function getRadius() : real
    result radius
  end getRadius

  function getMass(): int
    result mass
  end getMass
  
  function isMoving () : boolean
    result vx > .01 or vx < -.01 or vy > .01 or vy < -.01
  end isMoving

  function getDistance(o: pointer to PhysOb): real
    result sqrt((o-> getX() - x)**2 + (o -> getY() - y)**2)
  end getDistance
  
  function gravity_force(o: pointer to PhysOb): vector
    var v:vector
    var f:real := G * mass * o-> getMass() / getDistance(o)**2
    %put "F scalar " + realstr(f,4)
    var theta: real := arctan((o->getX() - x)/(o->getY() - y))
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
      if x  < 0 then
	x := maxx
      elsif x  > maxx then
	x := 0
      end if
      if y  < 0 then
	y := maxy 
      elsif y  > maxy then
	y := 0
      end if
    elsif geometry = BOUNCE then
      % collision with walls.  Walls have infinite mass and collision is almost elastic
       if y - radius < 5 or y + radius + 5 > maxy then
	     vy:=-vy*collision_recoil
       end if
       if x -radius < 5 or x + radius + 5> maxx then
	 vx:=-vx*collision_recoil
       end if
    elsif geometry = CLIP then
      % just let it go offscreen
    end if
  end doGeometry

  proc doFloorGravity(seconds:real)
    % In reality gravity does not stop at the floor, rather it should be 
    % balanced by an upward force exterted by the floor
    if y - radius > 2 then
      vy := vy + (-100 / mass) * seconds
    end if
  end doFloorGravity

  proc step (seconds: real)
    if floor_gravity then
      doFloorGravity(seconds)
    end if

    drawline(floor(x), floor(y), floor(x + vx), floor(y+vy), blue)
    % acceleration = force/mass
    % acceleration * time = change in velocity
    vx := vx + forces.x * seconds / mass
    vy := vy + forces.y * seconds / mass

    x:=x+vx*seconds
    y:=y+vy*seconds

    doGeometry
 
  end step

end PhysOb

