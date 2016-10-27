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
b -> initialize(10,20, blue, 100, maxy-20-80, 40,0)
sim -> addObj(b)


/*
new b
b -> initialize(10,20, blue, 300, 100, -10, 50)
sim -> addObj(b)
*/
/*
new b
b -> initialize(20,30, green, 150, maxy-0, 20, -20)
sim -> addObj(b)
*/

sim-> run(20)

/*
var middle: vector := make_vector(maxx/2, maxy/2)

var v: vector := make_vector(maxx/2+120, 50)

put "middle=" + vector_str(middle) + " v=" + vector_str(v)
put vector_str(vector_difference(middle,v))
put vector_str(vector_difference(v,middle))

put "distance m,v= " + realstr(vector_distance(middle,v),2) + " v,m= " + realstr(vector_distance(v,middle),2)

put "Bearing UP = " + realstr(vector_bearing(middle, make_vector(maxx/2, 400)),2)
put "Bearing DOWN = " + realstr(vector_bearing(middle, make_vector(maxx/2, 1)),2)

put "Bearing RIGHT = " + realstr(vector_bearing(middle, make_vector(maxx/2 + 200, maxy/2+0)),2)
put "Bearing WEST = " + realstr(vector_bearing(middle, make_vector(maxx/2  - 200, maxy/2+1)),2)
*/
