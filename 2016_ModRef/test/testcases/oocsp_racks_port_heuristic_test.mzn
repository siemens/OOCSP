include "../oocsp_racks_port_gen.mzn";
include "../oocsp_racks_port_constraints.mzn";

OTYPEINCREASING = true;

solve 
::seq_search([
% dont create additional objects
int_search([nrofobjects[o] | o in 1..NROFCLASSES], input_order, indomain_min, complete),
% fix typeof
int_search(otype, input_order, indomain_min, complete),
int_search([Rack_frames_port[o,s] |o in Objects, s in 1..8], input_order, indomain_min, complete),
int_search([Element_modules_port[o,s] |o in Objects, s in 1..6], input_order, indomain_min, complete),
int_search([Frame_modules_port[o,s] | o in Objects, s in 1..6], input_order, indomain_max, complete),
])
satisfy;
