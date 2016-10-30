include "vector.t"
include "config.t"
include "physob.t"
include "ball.t"
include "sun.t"
include "simulator.t"

var config: pointer to Configuration
new config

% To run this, make run window 50 rows by 150 

% TODO
% collisions between balls

var sim: pointer to Simulator
new sim
sim -> initialize(config)

var cx,cy: real
cx := maxx/2
cy := maxy/2

var sun: pointer to Sun
new sun
sun -> initialize(config, "sun", 100000, 25, yellow, cx, cy,0,0)
sim -> addObj(sun)

var p1   : pointer to Ball; new p1
var moon: pointer to Ball; new moon
var p2: pointer to Ball; new p2
var p3: pointer to Ball; new p3

p1   -> initialize(config, "A",   1000,    6, blue,  cx-150,    cy,       0, 12)
moon -> initialize(config, "moon", 100,    5, grey,  cx-150-20, cy,       0, 15.5)
p2   -> initialize(config, "B",     10,    4, red,   cx,        cy+50,    22, 0)
p3   -> initialize(config, "C",   2000,   12, green, cx,        cy -220, -11, 0)

sim -> addObj(p1)
%sim -> addObj(moon)
sim -> addObj(p2)
sim -> addObj(p3)

sim -> run(600)
