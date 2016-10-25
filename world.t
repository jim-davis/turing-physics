include "vector.t"
include "physob.t"
include "ball.t"
include "sun.t"
include "simulator.t"

var have_sun: boolean:=true
geometry:=WRAP
floor_gravity:=false

% note that floor_gravity and WRAP means objects accelerate forever!

% TODO
% collisions between balls
% gravity between balls. 

var sim: pointer to Simulator
new sim
sim -> initialize(have_sun)

  var sun: pointer to Sun
if have_sun then

  new sun
  sun -> initialize(1000000,50, yellow, maxx/2, maxy/2,0,0)
  sim -> addObj(sun)
end if

var b: pointer to Ball

new b
b -> initialize(10,20, gray, 100, maxy-20-80, 20,0)
sim -> addObj(b)


/*
new b
b -> initialize(10,20, blue, 300, 100, -10, 50)
sim -> addObj(b)

new b
b -> initialize(20,30, green, 150, maxy-50, 20, -20)
sim -> addObj(b)
*/

sim-> run(1)




