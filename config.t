var WRAP:string:="wrap"
var BOUNCE:string:="bounce"
var CLIP:string:="clip"

class Configuration
  import WRAP,BOUNCE,CLIP
  export geometry, G, floor_gravity, hasGravity, collision_recoil, draw_velocity_vector, draw_force_vector, font, draw_history, history_sample_period_msec

  % note that floor_gravity=true and geometry=WRAP means objects accelerate forever!  Not good

  var geometry:string:=WRAP
  var floor_gravity: boolean:=false
  var collision_recoil:real:=1  % "energy" retained after collision with wall.  1 means elastic
  var G: real := .25  % gravitational constant
  var draw_velocity_vector: boolean:=false
  var draw_force_vector : boolean :=false
  var font:int:=Font.New("serif:12")
  var draw_history: boolean := true
  var history_sample_period_msec: int := 500

  function hasGravity() : boolean
    result G > 0
  end hasGravity


end Configuration


  
