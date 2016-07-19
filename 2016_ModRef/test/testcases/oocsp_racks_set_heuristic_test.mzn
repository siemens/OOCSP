include "../oocsp_racks_set_gen.mzn";
include "../oocsp_racks_set_constraints.mzn";

OTYPEINCREASING = true;

solve 
::seq_search([
% dont create additional objects
int_search(
[nrofobjects[o] | o in 1..NROFCLASSES], input_order, indomain_min, complete),
% fix typeof
int_search(otype, input_order, indomain_min, complete),
%
set_search(Rack_frames, input_order, indomain_min, complete),
set_search(Element_modules, input_order, indomain_min, complete),
set_search(Frame_modules, input_order, indomain_max, complete),
])
satisfy;
