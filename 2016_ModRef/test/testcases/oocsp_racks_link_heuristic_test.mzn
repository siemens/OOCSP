%int : MAXNROFOBJECTS = 0;
include "../oocsp_racks_link_gen.mzn";
include "../oocsp_racks_link_constraints.mzn";

OTYPEINCREASING = true;

solve 
::seq_search([
% dont create additional objects
int_search([nrofobjects[o] | o in 1..NROFCLASSES], input_order, indomain_min, complete),
% fix typeof
int_search(otype, input_order, indomain_min, complete),
int_search(Frame_rack, input_order, indomain_min, complete),
int_search(Module_element, input_order, indomain_min, complete),
int_search(Module_frame, input_order, indomain_min, complete),
])
satisfy;
