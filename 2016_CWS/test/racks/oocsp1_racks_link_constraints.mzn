% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

% constraint for configtype1
% root class
constraint
    nrofobjects[CLASS_Configuration] = 1;

% element<->module
constraint
  forall (o in OBJECTS where isA(CLASS_ElementA,o)) (hasNObjects(o,Module_element,CLASS_Module,1,1));

constraint
 forall (o in OBJECTS where isA(CLASS_ElementA,o)) (isA(o,Module_element,CLASS_ModuleI));

% element<->module
constraint
  forall (o in OBJECTS where isA(CLASS_ElementB,o)) (hasNObjects(o,Module_element,CLASS_Module,2,2));

constraint
 forall (o in OBJECTS where isA(CLASS_ElementB,o)) (isA(o,Module_element,CLASS_ModuleII));

% element<->module
constraint
  forall (o in OBJECTS where isA(CLASS_ElementC,o)) (hasNObjects(o,Module_element,CLASS_Module,3,3));

constraint
 forall (o in OBJECTS where isA(CLASS_ElementC,o)) (isA(o,Module_element,CLASS_ModuleIII));

% element<->module
constraint
  forall (o in OBJECTS where isA(CLASS_ElementD,o)) (hasNObjects(o,Module_element,CLASS_Module,4,4));

constraint
 forall (o in OBJECTS where isA(CLASS_ElementD,o)) (isA(o,Module_element,CLASS_ModuleIV));

% moduleV has no element
constraint
  forall (o in OBJECTS where isA(CLASS_Element,o)) (hasNObjects(o,Module_element,CLASS_ModuleV,0,0));

% all other modules have a element
constraint
    forall(o in OBJECTS) 
    (if (isA(CLASS_ModuleI,o)\/isA(CLASS_ModuleII,o)\/isA(CLASS_ModuleIII,o)\/isA(CLASS_ModuleIV,o)) then Module_element[o]>0 else true endif); 

% constraints for moduleV
constraint
  forall (o1 in OBJECTS where isA(CLASS_ModuleII,o1)) 
    (exists (o2 in OBJECTS) (isA(CLASS_ModuleV,o2) /\ Module_frame[o1]=Module_frame[o2]));

% all modules of an element must be in the same frame
constraint
  forall (o1,o2 in OBJECTS where isA(CLASS_Module,o1)/\isA(CLASS_Module,o2)/\o1!=o2) 
    (if ((Module_element[o1]!=0)/\(Module_element[o1]=Module_element[o2])) then (Module_frame[o1]=Module_frame[o2]) else true endif);

% racks<->frame constraint
constraint
  forall (o in OBJECTS where isA(CLASS_RackSingle,o)) (hasNObjects(o,Frame_rack,CLASS_Frame,4,4));

constraint
  forall (o in OBJECTS where isA(CLASS_RackDouble,o)) (hasNObjects(o,Frame_rack,CLASS_Frame,8,8));

bool: USECARDINALITYCONSTRAINTS;

constraint
if USECARDINALITYCONSTRAINTS then
% todo manual
nrofobjects[CLASS_Frame]>=nrofobjects[CLASS_RackSingle]*4 /\
nrofobjects[CLASS_Frame]>=nrofobjects[CLASS_RackDouble]*8 /\
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
