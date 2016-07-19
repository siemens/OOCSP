% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

%
% File for testing the generated model and the domain specific constraints
%

include "../oocsp1_buildings_link_gen.mzn";
include "../oocsp1_buildings_link_constraints.mzn";


solve satisfy;