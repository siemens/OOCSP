% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

include "oocsp_racks_cc.mzn";

% constraint for configtype1
% root class
constraint
    nrofobjects[CLASS_Configuration] = 1;

% element<->module
constraint
  forall (o in Objects where instanceof(o,CLASS_ElementA)) (hasNObjects(o,Module_element,CLASS_Module,1,1));

constraint
 forall (o in Objects where instanceof(o,CLASS_ElementA)) (isA(o,Module_element,CLASS_ModuleI));

% element<->module
constraint
  forall (o in Objects where instanceof(o,CLASS_ElementB)) (hasNObjects(o,Module_element,CLASS_Module,2,2));

constraint
 forall (o in Objects where instanceof(o,CLASS_ElementB)) (isA(o,Module_element,CLASS_ModuleII));

% element<->module
constraint
  forall (o in Objects where instanceof(o,CLASS_ElementC)) (hasNObjects(o,Module_element,CLASS_Module,3,3));

constraint
 forall (o in Objects where instanceof(o,CLASS_ElementC)) (isA(o,Module_element,CLASS_ModuleIII));

% element<->module
constraint
  forall (o in Objects where instanceof(o,CLASS_ElementD)) (hasNObjects(o,Module_element,CLASS_Module,4,4));

constraint
 forall (o in Objects where instanceof(o,CLASS_ElementD)) (isA(o,Module_element,CLASS_ModuleIV));

% moduleV has no element
constraint
  forall (o in Objects where instanceof(o,CLASS_Element)) (hasNObjects(o,Module_element,CLASS_ModuleV,0,0));

% all other modules have a element
constraint
    forall(o in Objects) 
    (if (instanceof(o,CLASS_ModuleI)\/instanceof(o,CLASS_ModuleII)\/instanceof(o,CLASS_ModuleIII)\/instanceof(o,CLASS_ModuleIV)) then Module_element[o]>0 else true endif); 

% constraints for moduleV
constraint
  forall (o1 in Objects where instanceof(o1,CLASS_ModuleII)) 
    (exists (o2 in Objects) (instanceof(o2,CLASS_ModuleV) /\ Module_frame[o1]=Module_frame[o2]));

% all modules of an element must be in the same frame
constraint
  forall (o1,o2 in Objects where instanceof(o1,CLASS_Module)/\instanceof(o2,CLASS_Module)/\o1!=o2) 
    (if ((Module_element[o1]!=0)/\(Module_element[o1]=Module_element[o2])) then (Module_frame[o1]=Module_frame[o2]) else true endif);

% racks<->frame constraint
constraint
  forall (o in Objects where instanceof(o,CLASS_RackSingle)) (hasNObjects(o,Frame_rack,CLASS_Frame,4,4));

constraint
  forall (o in Objects where instanceof(o,CLASS_RackDouble)) (hasNObjects(o,Frame_rack,CLASS_Frame,8,8));


