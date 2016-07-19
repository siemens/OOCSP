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
  forall (o in Objects)
    (instanceof(o,CLASS_Element)<->
     instanceof(Element_modules_port[o,6],CLASS_Module));

constraint
  forall (o in Objects)
    (instanceof(o,CLASS_ElementA)<->
    (Element_modules_port[o,1]=0 /\ 
     Element_modules_port[o,2]=0 /\
     Element_modules_port[o,3]=0 /\
     Element_modules_port[o,4]=0 /\
     Element_modules_port[o,5]=0 /\
     instanceof(Element_modules_port[o,6],CLASS_ModuleI)));

constraint
  forall (o in Objects) 
    (instanceof(o,CLASS_ElementB)<->
    (Element_modules_port[o,1]=0 /\ 
     Element_modules_port[o,2]=0 /\
     Element_modules_port[o,3]=0 /\
     Element_modules_port[o,4]=0 /\
     instanceof(Element_modules_port[o,5],CLASS_ModuleII) /\
     instanceof(Element_modules_port[o,6],CLASS_ModuleII)));

constraint
  forall (o in Objects) 
    (instanceof(o,CLASS_ElementC)<->
    (Element_modules_port[o,1]=0 /\ 
     Element_modules_port[o,2]=0 /\
     Element_modules_port[o,3]=0 /\
     instanceof(Element_modules_port[o,4],CLASS_ModuleIII) /\
     instanceof(Element_modules_port[o,5],CLASS_ModuleIII) /\
     instanceof(Element_modules_port[o,6],CLASS_ModuleIII)));

constraint
  forall (o in Objects) 
    (instanceof(o,CLASS_ElementD)<->
    (Element_modules_port[o,1]=0 /\ 
     Element_modules_port[o,2]=0 /\
     instanceof(Element_modules_port[o,3],CLASS_ModuleIV) /\
     instanceof(Element_modules_port[o,4],CLASS_ModuleIV) /\
     instanceof(Element_modules_port[o,5],CLASS_ModuleIV) /\
     instanceof(Element_modules_port[o,6],CLASS_ModuleIV)));

% Rack <-> Frame
constraint
  forall (o in Objects) 
    (instanceof(o,CLASS_Rack)<->(
    instanceof(Rack_frames_port[o,5],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,6],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,7],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,8],CLASS_Frame)));

constraint
  forall (o in Objects) 
  (instanceof(o,CLASS_RackSingle) <-> (
    Rack_frames_port[o,1]=0 /\
    Rack_frames_port[o,2]=0 /\
    Rack_frames_port[o,3]=0 /\
    Rack_frames_port[o,4]=0 /\
    instanceof(Rack_frames_port[o,5],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,6],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,7],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,8],CLASS_Frame)));

constraint
  forall (o in Objects) 
  (instanceof(o,CLASS_RackDouble) <-> (
    instanceof(Rack_frames_port[o,1],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,2],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,3],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,4],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,5],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,6],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,7],CLASS_Frame) /\
    instanceof(Rack_frames_port[o,8],CLASS_Frame)));

constraint
  forall (o in Objects where not instanceof(o,CLASS_Rack)) 
   (Rack_frames_port[o,8]=0);

% constraints for moduleV
constraint
  forall (o1 in Objects where instanceof(o1,CLASS_ModuleII)) 
    (exists (o2 in Objects) (instanceof(o2,CLASS_ModuleV) /\ Module_frame[o1]=Module_frame[o2]));

% redundant - disallow ModuleII in port 1 and 2
constraint
  forall (o in Objects where instanceof(o,CLASS_Frame)) 
    (not instanceof(Frame_modules_port[o,1],CLASS_ModuleII) /\ 
     not instanceof(Frame_modules_port[o,2],CLASS_ModuleII));

% all modules of an element must be in the same frame
constraint
  forall (o1,o2 in Objects where instanceof(o1,CLASS_Module)/\instanceof(o2,CLASS_Module)/\o1<o2) 
    (if ((Module_element[o1]!=0)/\(Module_element[o1]=Module_element[o2])) then (Module_frame[o1]=Module_frame[o2]) else true endif);

