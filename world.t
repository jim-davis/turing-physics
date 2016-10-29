include "vector.t"
include "config.t"
include "physob.t"
include "ball.t"
include "sun.t"
include "simulator.t"

var config: pointer to Configuration
new config

% note that floor_gravity and WRAP means objects accelerate forever!

% TODO
% collisions between balls
% draw path (record history of position)

var sim: pointer to Simulator
new sim
sim -> initialize(config)

var sun: pointer to Sun
new sun
sun -> initialize(config, "sun", 1000000,20, yellow, maxx/2, maxy/2,0,0)
sim -> addObj(sun)

var p1: pointer to Ball
new p1
p1 -> initialize(config, "A", 10,4, blue, 110, maxy/2-100, -2, 10)

var p2: pointer to Ball
new p2
p2 -> initialize(config, "B", 10, 4, red, 300, 300, 10, 0)

var p3: pointer to Ball
new p3
p3 -> initialize(config, "C", 30, 5, green, 150, maxy-40, 18, -8)

%sim -> addObj(p1)
%sim -> addObj(p2)
sim -> addObj(p3)

%sim-> step(1)


sim -> run(60)
