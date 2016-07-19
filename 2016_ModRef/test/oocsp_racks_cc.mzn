% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

% Cardinality constraints for rack example

bool: USECARDINALITYCONSTRAINTS;

constraint
if USECARDINALITYCONSTRAINTS then
% todo manual
nrofobjects[CLASS_Frame]>=nrofobjects[CLASS_Rack]*4 /\
nrofobjects[CLASS_Frame]>=nrofobjects[CLASS_RackSingle]*4 /\
nrofobjects[CLASS_Frame]>=nrofobjects[CLASS_RackDouble]*8 /\
nrofobjects[CLASS_Module]>=nrofobjects[CLASS_Element] /\
nrofobjects[CLASS_ModuleI]=nrofobjects[CLASS_ElementA] /\
nrofobjects[CLASS_ModuleII]=2*nrofobjects[CLASS_ElementB] /\
nrofobjects[CLASS_ModuleIII]=3*nrofobjects[CLASS_ElementC] /\
nrofobjects[CLASS_ModuleIV]=4*nrofobjects[CLASS_ElementD] /\
% ?
nrofobjects[CLASS_ModuleV] >= ((2 + nrofobjects[CLASS_ElementB]) div 3) /\
% automatic
0*nrofobjects[CLASS_Configuration] + -1*nrofobjects[CLASS_Element]<=0 /\
1*nrofobjects[CLASS_ElementC] + -1*nrofobjects[CLASS_Element]<=0 /\
0*nrofobjects[CLASS_Configuration] + -1*nrofobjects[CLASS_RackDouble] + -1*nrofobjects[CLASS_RackSingle]<=0 /\
1*nrofobjects[CLASS_ElementA] + 1*nrofobjects[CLASS_ElementB] + 1*nrofobjects[CLASS_ElementC] + 1*nrofobjects[CLASS_ElementD] + -1*nrofobjects[CLASS_Element]=0 /\
1*nrofobjects[CLASS_ElementB] + -1*nrofobjects[CLASS_Element]<=0 /\
1*nrofobjects[CLASS_ModuleIV] + -1*nrofobjects[CLASS_Module]<=0 /\
1*nrofobjects[CLASS_ModuleI] + 1*nrofobjects[CLASS_ModuleII] + 1*nrofobjects[CLASS_ModuleIII] + 1*nrofobjects[CLASS_ModuleIV] + 1*nrofobjects[CLASS_ModuleV] + -1*nrofobjects[CLASS_Module]=0 /\
1*nrofobjects[CLASS_ElementA] + -1*nrofobjects[CLASS_Element]<=0 /\
0*nrofobjects[CLASS_Module] + -6*nrofobjects[CLASS_ElementA] + -6*nrofobjects[CLASS_ElementC] + -6*nrofobjects[CLASS_ElementD] + -6*nrofobjects[CLASS_ElementB]<=0 /\
0*nrofobjects[CLASS_Element] + -1*nrofobjects[CLASS_ElementD]<=0 /\
0*nrofobjects[CLASS_Module] + -1*nrofobjects[CLASS_ModuleIV]<=0 /\
1*nrofobjects[CLASS_ModuleIII] + -1*nrofobjects[CLASS_Module]<=0 /\
0*nrofobjects[CLASS_Element] + -1*nrofobjects[CLASS_ModuleIV] + -1*nrofobjects[CLASS_ModuleIII] + -1*nrofobjects[CLASS_ModuleII] + -1*nrofobjects[CLASS_ModuleI] + -1*nrofobjects[CLASS_ModuleV]<=0 /\
0*nrofobjects[CLASS_Module] + -1*nrofobjects[CLASS_ModuleI]<=0 /\
1*nrofobjects[CLASS_ModuleII] + -1*nrofobjects[CLASS_Module]<=0 /\
1*nrofobjects[CLASS_Configuration]<=1 /\
1*nrofobjects[CLASS_Frame] + -8*nrofobjects[CLASS_RackSingle] + -8*nrofobjects[CLASS_RackDouble]<=0 /\
1*nrofobjects[CLASS_Module] + -6*nrofobjects[CLASS_Frame]<=0 /\
1*nrofobjects[CLASS_ElementD] + -1*nrofobjects[CLASS_Element]<=0 /\
1*nrofobjects[CLASS_RackSingle] + 1*nrofobjects[CLASS_RackDouble] + -1*nrofobjects[CLASS_Rack]=0 /\
0*nrofobjects[CLASS_Element] + -1*nrofobjects[CLASS_ElementB]<=0 /\
6*nrofobjects[CLASS_Element] + 0*nrofobjects[CLASS_ModuleV] + 0*nrofobjects[CLASS_ModuleIV] + 0*nrofobjects[CLASS_ModuleI] + 0*nrofobjects[CLASS_ModuleII] + 0*nrofobjects[CLASS_ModuleIII]>=0 /\
0*nrofobjects[CLASS_Rack] + -1*nrofobjects[CLASS_Frame]<=0 /\
1*nrofobjects[CLASS_ModuleV] + -1*nrofobjects[CLASS_Module]<=0 /\
0*nrofobjects[CLASS_Module] + -6*nrofobjects[CLASS_Element]<=0 /\
1*nrofobjects[CLASS_ModuleI] + -1*nrofobjects[CLASS_Module]<=0 /\
1*nrofobjects[CLASS_Module] + 0*nrofobjects[CLASS_ElementD] + 0*nrofobjects[CLASS_ElementA] + 0*nrofobjects[CLASS_ElementB] + 0*nrofobjects[CLASS_ElementC]>=0 /\
100*nrofobjects[CLASS_Configuration] + -1*nrofobjects[CLASS_RackSingle] + -1*nrofobjects[CLASS_RackDouble]>=0 /\
100*nrofobjects[CLASS_Configuration] + -1*nrofobjects[CLASS_ElementA] + -1*nrofobjects[CLASS_ElementC] + -1*nrofobjects[CLASS_ElementB] + -1*nrofobjects[CLASS_ElementD]>=0 /\
0*nrofobjects[CLASS_Element] + -1*nrofobjects[CLASS_Module]<=0 /\
0*nrofobjects[CLASS_Frame] + -1*nrofobjects[CLASS_Module]<=0 /\
1*nrofobjects[CLASS_Frame] + 0*nrofobjects[CLASS_RackSingle] + 0*nrofobjects[CLASS_RackDouble]>=0 /\
0*nrofobjects[CLASS_Element] + -1*nrofobjects[CLASS_ElementA]<=0 /\
0*nrofobjects[CLASS_Configuration] + -1*nrofobjects[CLASS_ElementB] + -1*nrofobjects[CLASS_ElementC] + -1*nrofobjects[CLASS_ElementD] + -1*nrofobjects[CLASS_ElementA]<=0 /\
0*nrofobjects[CLASS_Frame] + -1*nrofobjects[CLASS_ModuleV] + -1*nrofobjects[CLASS_ModuleIV] + -1*nrofobjects[CLASS_ModuleII] + -1*nrofobjects[CLASS_ModuleI] + -1*nrofobjects[CLASS_ModuleIII]<=0 /\
1*nrofobjects[CLASS_Rack] + -100*nrofobjects[CLASS_Configuration]<=0 /\
1*nrofobjects[CLASS_RackSingle] + -1*nrofobjects[CLASS_Rack]<=0 /\
0*nrofobjects[CLASS_Module] + -1*nrofobjects[CLASS_ModuleII]<=0 /\
6*nrofobjects[CLASS_Frame] + -1*nrofobjects[CLASS_ModuleI] + -1*nrofobjects[CLASS_ModuleIV] + -1*nrofobjects[CLASS_ModuleIII] + -1*nrofobjects[CLASS_ModuleV] + -1*nrofobjects[CLASS_ModuleII]>=0 /\
0*nrofobjects[CLASS_Element] + -1*nrofobjects[CLASS_ElementC]<=0 /\
1*nrofobjects[CLASS_Element] + -100*nrofobjects[CLASS_Configuration]<=0 /\
0*nrofobjects[CLASS_Module] + -1*nrofobjects[CLASS_ModuleIII]<=0 /\
1*nrofobjects[CLASS_Configuration]>=1 /\
0*nrofobjects[CLASS_Rack] + -1*nrofobjects[CLASS_RackDouble]<=0 /\
1*nrofobjects[CLASS_Frame] + -8*nrofobjects[CLASS_Rack]<=0 /\
0*nrofobjects[CLASS_Rack] + -1*nrofobjects[CLASS_RackSingle]<=0 /\
0*nrofobjects[CLASS_Module] + -1*nrofobjects[CLASS_ModuleV]<=0 /\
1*nrofobjects[CLASS_RackDouble] + -1*nrofobjects[CLASS_Rack]<=0 /\
0*nrofobjects[CLASS_Configuration] + -1*nrofobjects[CLASS_Rack]<=0
else
true
endif;
