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

var sim: pointer to Simulator; new sim
sim -> initialize(config)

var cx,cy: real
cx := maxx/2
cy := maxy/2

var sun:     pointer to Sun; new sun
var earth:   pointer to Ball; new earth
var mars:    pointer to Ball; new mars
var jupiter: pointer to Ball; new jupiter

% Mass and Radius are to scale.  
% display size is not to scale.
% velocity is supposed to be to scale (to make one year= 60 seconds
% but the velocities were too slow.  I must have made an error somewhere
% Earth   6.00E+24 kg  1.49E+08 km
% Mars    6.39E+23 kg  2.27E+08 km
% Jupiter 1.90E+27 kg  7.78E+08 km
% Sun     1.99E+30 kg

sun      -> initialize(config, "S", 331500,   25, yellow, cx,    cy, 0, 0)
earth    -> initialize(config, "E",      1,    6, blue,   cx-76, cy, 0, 25.5)
mars     -> initialize(config, "M",   .107,    4, red,    cx-116, cy, 0, 22.5)
jupiter  -> initialize(config, "J",    316,   12, green,  cx-400, cy, 0, 12.54)

sim -> addObj(sun)
sim -> addObj(earth)
sim -> addObj(mars)
sim -> addObj(jupiter)

sim -> run(600)
