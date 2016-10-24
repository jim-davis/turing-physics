
var have_sun: boolean:=true

include "physob.t"

include "ball.t"
include "sun.t"
include "simulator.t"

% note that floor_gravity and WRAP means objects accelerate forever!

% TODO
% collisions between balls
% gravity between balls.  The SUN

var sim: pointer to Simulator
new sim

var b: pointer to Ball

new b
b -> initialize(10,20, red, 100, maxy-20-10, 20,0)
sim -> addObj(b)

new b
b -> initialize(10,20, blue, 300, 100, -10, 50)
sim -> addObj(b)

new b
b -> initialize(20,30, green, 150, maxy-50, 20, -20)
sim -> addObj(b)

if have_sun then
  var sun: pointer to Sun
  new sun
  sun -> initialize(10000,50, yellow, maxx/2, maxy/2,0,0)
  sim -> addSun(sun)
end if

sim-> run(1000)


