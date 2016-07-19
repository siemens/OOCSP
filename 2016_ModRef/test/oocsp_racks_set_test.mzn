% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

%
% File for testing the generated model and the domain specific constraints
%

include "oocsp_racks_set_constraints.mzn";
include "oocsp_racks_set_gen.mzn";
include "oocsp_racks_set_test.dzn";

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
