% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

include "oocsp_racks_cc.mzn";

predicate hasExactlyNObjectsSet(int: object, array[int] of var set of int: assoc, int: class, int: min, int: max) = 
  (card(assoc[object]) >= min /\ card(assoc[object]) <= max /\ forall (o in Objects) (if (o in assoc[object]) then instanceof(o,class) else true endif));

% constraint for configtype1
% root class
constraint
    nrofobjects[CLASS_Configuration] = 1;

% element<->module
constraint
  forall (o in Objects where instanceof(o,CLASS_ElementA)) (hasExactlyNObjectsSet(o,Element_modules,CLASS_ModuleI,1,1));

constraint
  forall (o in Objects where instanceof(o,CLASS_ElementB)) (hasExactlyNObjectsSet(o,Element_modules,CLASS_ModuleII,2,2));

constraint
  forall (o in Objects where instanceof(o,CLASS_ElementC)) (hasExactlyNObjectsSet(o,Element_modules,CLASS_ModuleIII,3,3));

constraint
  forall (o in Objects where instanceof(o,CLASS_ElementD)) (hasExactlyNObjectsSet(o,Element_modules,CLASS_ModuleIV,4,4));


% all other modules have a element
constraint
    forall(o in Objects) 
    (if (instanceof(o,CLASS_ModuleI)\/instanceof(o,CLASS_ModuleII)\/instanceof(o,CLASS_ModuleIII)\/instanceof(o,CLASS_ModuleIV)) then Module_element[o]!={} else true endif); 

% constraints for moduleV
constraint
  forall (o1 in Objects where instanceof(o1,CLASS_ModuleII)) 
    (exists (o2 in Objects) (instanceof(o2,CLASS_ModuleV) /\ Module_frame[o1]=Module_frame[o2]));

% all modules of an element must be in the same frame
constraint
  forall (o1,o2 in Objects where instanceof(o1,CLASS_Module)/\instanceof(o2,CLASS_Module)/\o1!=o2) 
    (if ((Module_element[o1]!={})/\(Module_element[o1]=Module_element[o2])) then (Module_frame[o1]=Module_frame[o2]) else true endif);

% racks<->frame constraint
constraint
  forall (o in Objects where instanceof(o,CLASS_RackSingle)) (hasExactlyNObjectsSet(o,Rack_frames,CLASS_Frame,4,4));

constraint
  forall (o in Objects where instanceof(o,CLASS_RackDouble)) (hasExactlyNObjectsSet(o,Rack_frames,CLASS_Frame,8,8));

