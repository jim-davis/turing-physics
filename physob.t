var WRAP:string:="wrap"
var BOUNCE:string:="bounce"
var CLIP:string:="clip"

var geometry:string:=WRAP
var floor_gravity: boolean:=false

% a physical object at a point with mass and velocity
class PhysOb
  import geometry,WRAP,BOUNCE,CLIP,floor_gravity
  export initialize,draw,hide,step,isMoving
  deferred procedure step(seconds: real)
  deferred procedure draw
  deferred procedure hide
  var x,y:real:=0
  var mass: int:=100 % grams
  var radius: int :=20  % pixels
  var vx,vy: real  :=0 % pixels/second
  var mycolour:int := red
  var collision_recoil:real:=1

  proc initialize(mass_, radius_, colour_: int, x_, y_, vx_, vy_: real)
    mass:=mass
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
  
  function isMoving () : boolean
    result vx > .01 or vx < -.01 or vy > .01 or vy < -.01
  end isMoving
  

end PhysOb

