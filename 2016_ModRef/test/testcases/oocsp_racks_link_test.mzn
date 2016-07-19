%int : MAXNROFOBJECTS = 0;
include "../oocsp_racks_link_gen.mzn";
include "../oocsp_racks_link_constraints.mzn";

OTYPEINCREASING = true;

solve 
satisfy;
