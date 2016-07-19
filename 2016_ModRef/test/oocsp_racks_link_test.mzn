% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

%
% File for testing the generated model and the domain specific constraints
%

include "oocsp_racks_link_constraints.mzn";
include "oocsp_racks_link_gen.mzn";
include "oocsp_racks_link_test.dzn";

OTYPEINCREASING = false;
USECARDINALITYCONSTRAINTS = true;
 
solve 
% TODO: performs better - Why? 
%::int_search(Frame_rack, input_order, indomain_max, complete)
satisfy;