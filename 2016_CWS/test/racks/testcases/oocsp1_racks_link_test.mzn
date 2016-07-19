% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

%int : MAXNROFOBJECTS = 0;
include "../oocsp1_racks_link_gen.mzn";
include "../oocsp1_racks_link_constraints.mzn";

solve satisfy;
