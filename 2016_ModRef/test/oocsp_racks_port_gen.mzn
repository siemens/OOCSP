% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

include "../../oocsp.mzn";
include "increasing.mzn";
include "global_cardinality.mzn";

NROFCLASSES = 16;
classnames = ["Configuration", "Element", "ElementA", "ElementB", "ElementC", "ElementD", "Frame", "Module", "ModuleI", "ModuleII", "ModuleIII", "ModuleIV", "ModuleV", "Rack", "RackDouble", "RackSingle"];
superclass = [0, 0, CLASS_Element, CLASS_Element, CLASS_Element, CLASS_Element, 0, 0, CLASS_Module, CLASS_Module, CLASS_Module, CLASS_Module, CLASS_Module, 0, CLASS_Rack, CLASS_Rack];

int : CLASS_Configuration = 1;
int : CLASS_Configuration_MIN;
int : CLASS_Configuration_MAX;
constraint CLASS_Configuration_MIN <= nrofobjects[CLASS_Configuration] /\ nrofobjects[CLASS_Configuration] <= CLASS_Configuration_MAX;
constraint nrofobjects[CLASS_Configuration] = 1;
int : CLASS_Element = 2;
int : CLASS_Element_MIN;
int : CLASS_Element_MAX;
constraint CLASS_Element_MIN <= nrofobjects[CLASS_Element] /\ nrofobjects[CLASS_Element] <= CLASS_Element_MAX;
int : CLASS_ElementA = 3;
int : CLASS_ElementA_MIN;
int : CLASS_ElementA_MAX;
constraint CLASS_ElementA_MIN <= nrofobjects[CLASS_ElementA] /\ nrofobjects[CLASS_ElementA] <= CLASS_ElementA_MAX;
int : CLASS_ElementB = 4;
int : CLASS_ElementB_MIN;
int : CLASS_ElementB_MAX;
constraint CLASS_ElementB_MIN <= nrofobjects[CLASS_ElementB] /\ nrofobjects[CLASS_ElementB] <= CLASS_ElementB_MAX;
int : CLASS_ElementC = 5;
int : CLASS_ElementC_MIN;
int : CLASS_ElementC_MAX;
constraint CLASS_ElementC_MIN <= nrofobjects[CLASS_ElementC] /\ nrofobjects[CLASS_ElementC] <= CLASS_ElementC_MAX;
int : CLASS_ElementD = 6;
int : CLASS_ElementD_MIN;
int : CLASS_ElementD_MAX;
constraint CLASS_ElementD_MIN <= nrofobjects[CLASS_ElementD] /\ nrofobjects[CLASS_ElementD] <= CLASS_ElementD_MAX;
int : CLASS_Frame = 7;
int : CLASS_Frame_MIN;
int : CLASS_Frame_MAX;
constraint CLASS_Frame_MIN <= nrofobjects[CLASS_Frame] /\ nrofobjects[CLASS_Frame] <= CLASS_Frame_MAX;
int : CLASS_Module = 8;
int : CLASS_Module_MIN;
int : CLASS_Module_MAX;
constraint CLASS_Module_MIN <= nrofobjects[CLASS_Module] /\ nrofobjects[CLASS_Module] <= CLASS_Module_MAX;
int : CLASS_ModuleI = 9;
int : CLASS_ModuleI_MIN;
int : CLASS_ModuleI_MAX;
constraint CLASS_ModuleI_MIN <= nrofobjects[CLASS_ModuleI] /\ nrofobjects[CLASS_ModuleI] <= CLASS_ModuleI_MAX;
int : CLASS_ModuleII = 10;
int : CLASS_ModuleII_MIN;
int : CLASS_ModuleII_MAX;
constraint CLASS_ModuleII_MIN <= nrofobjects[CLASS_ModuleII] /\ nrofobjects[CLASS_ModuleII] <= CLASS_ModuleII_MAX;
int : CLASS_ModuleIII = 11;
int : CLASS_ModuleIII_MIN;
int : CLASS_ModuleIII_MAX;
constraint CLASS_ModuleIII_MIN <= nrofobjects[CLASS_ModuleIII] /\ nrofobjects[CLASS_ModuleIII] <= CLASS_ModuleIII_MAX;
int : CLASS_ModuleIV = 12;
int : CLASS_ModuleIV_MIN;
int : CLASS_ModuleIV_MAX;
constraint CLASS_ModuleIV_MIN <= nrofobjects[CLASS_ModuleIV] /\ nrofobjects[CLASS_ModuleIV] <= CLASS_ModuleIV_MAX;
int : CLASS_ModuleV = 13;
int : CLASS_ModuleV_MIN;
int : CLASS_ModuleV_MAX;
constraint CLASS_ModuleV_MIN <= nrofobjects[CLASS_ModuleV] /\ nrofobjects[CLASS_ModuleV] <= CLASS_ModuleV_MAX;
int : CLASS_Rack = 14;
int : CLASS_Rack_MIN;
int : CLASS_Rack_MAX;
constraint CLASS_Rack_MIN <= nrofobjects[CLASS_Rack] /\ nrofobjects[CLASS_Rack] <= CLASS_Rack_MAX;
int : CLASS_RackDouble = 15;
int : CLASS_RackDouble_MIN;
int : CLASS_RackDouble_MAX;
constraint CLASS_RackDouble_MIN <= nrofobjects[CLASS_RackDouble] /\ nrofobjects[CLASS_RackDouble] <= CLASS_RackDouble_MAX;
int : CLASS_RackSingle = 16;
int : CLASS_RackSingle_MIN;
int : CLASS_RackSingle_MAX;
constraint CLASS_RackSingle_MIN <= nrofobjects[CLASS_RackSingle] /\ nrofobjects[CLASS_RackSingle] <= CLASS_RackSingle_MAX;

array[Objects] of var 0..100:Configuration_configtype;
constraint
hasAttribute(CLASS_Configuration,Configuration_configtype,1,100);
% Element_configuration(1,1)<->Configuration_elements(0,100)
array[Objects] of var OptObjects: Element_configuration;
array[Objects] of var 0..MAXNROFOBJECTS: Configuration_elements_count;
constraint hasAssocLink(CLASS_Element,1,1,Element_configuration,CLASS_Configuration,0,100,Configuration_elements_count);

% Frame_rack(1,1)<->Rack_frames(0,8)
%array[Objects] of var OPT_OBJECT: Frame_rack;
% TODO: generic
array[Objects,1..8] of var OptObjects: Rack_frames_port;
constraint forall(o in Objects) (let { array[1..8] of var OptObjects : ports = [ Rack_frames_port[o,s] | s in 1..8]} in (increasing(ports)));
array[Objects] of var OptObjects: Frame_rack;
array[Objects] of var 0..1: Rack_frames_count;

constraint
  global_cardinality([ Rack_frames_port[o,s] | o in Objects, s in 1..8],Objects,Rack_frames_count);

% type of ports
constraint
  forall(o in Objects, s in 1..6)
    (if (instanceof(o,CLASS_Rack)) then 
    Rack_frames_port[o,s]=0 \/ instanceof(Rack_frames_port[o,s],CLASS_Frame)
    else
    Rack_frames_port[o,s]=0 
    endif);

% type of backlink
constraint
  forall(o in Objects where instanceof(o,CLASS_Frame))
    (instanceof(Frame_rack[o],CLASS_Rack));

% backlink is inverse of port
constraint
  forall(f in Objects where instanceof(f,CLASS_Frame))
    (exists(r in Objects, s in 1..8 where instanceof(r,CLASS_Rack)) (Rack_frames_port[r,s]=f));

constraint
  forall(r in Objects, s in 1..8 where instanceof(r,CLASS_Rack))
    (let { var OptObjects: frame = Rack_frames_port[r,s] } in
    (if (frame>0) then Frame_rack[frame] = r else true endif));

% Frame Modules
array[Objects,1..6] of var OptObjects: Frame_modules_port;
constraint forall(o in Objects) (let { array[1..6] of var OptObjects : ports = [ Frame_modules_port[o,s] | s in 1..6]} in (increasing(ports)));
array[Objects] of var 0..1: Frame_modules_count;

constraint
  global_cardinality([ Frame_modules_port[o,s] | o in Objects, s in 1..6],Objects,Frame_modules_count);

% Module frame
array[Objects] of var OptObjects: Module_frame;
array[Objects] of var 0..6: Module_frame_count;

constraint
  global_cardinality(Module_frame,Objects,Module_frame_count);

% type of ports
constraint
  forall(o in Objects, s in 1..6)
    (if (instanceof(o,CLASS_Frame)) then 
    Frame_modules_port[o,s]=0 \/ instanceof(Frame_modules_port[o,s],CLASS_Module)
    else
    Frame_modules_port[o,s]=0 
    endif);

% TODO: why is this necessary -> should be implied by constraint above
constraint
  forall(o1 in Objects)
    (forall(f in Objects, s in 1..6 where instanceof(f,CLASS_Frame))
      (if (not instanceof(o1,CLASS_Module)) then Frame_modules_port[f,s]!=o1 else true endif));

% type of backlink
constraint
  forall(o in Objects where instanceof(o,CLASS_Module))
    (instanceof(Module_frame[o],CLASS_Frame));

% backlink is inverse of port
constraint
  forall(m in Objects where instanceof(m,CLASS_Module))
    (exists(s in 1..6) (Frame_modules_port[Module_frame[m],s]=m));

constraint
  forall(o in Objects, s in 1..6 where instanceof(o,CLASS_Frame))
    (let { var OptObjects: module = Frame_modules_port[o,s] } in
    (if (module>0) then Module_frame[module] = o else true endif));

% Element modules
array[Objects,1..6] of var OptObjects: Element_modules_port;
constraint forall(o in Objects) (let { array[1..6] of var OptObjects : ports = [ Element_modules_port[o,s] | s in 1..6]} in (increasing(ports)));
array[Objects] of var OptObjects: Module_element;
array[Objects] of var 0..1: Element_modules_count;

constraint
  global_cardinality([ Element_modules_port[o,s] | o in Objects, s in 1..6],Objects,Element_modules_count);

% type of ports
constraint
  forall(o in Objects, s in 1..6)
    (if (instanceof(o,CLASS_Element)) then 
       Element_modules_port[o,s]=0 \/ instanceof(Element_modules_port[o,s],CLASS_Module)
     else
       Element_modules_port[o,s]=0 
     endif);

% type of backlink
constraint
  forall(o in Objects)
    (if (instanceof(o,CLASS_Module)/\(not instanceof(o,CLASS_ModuleV))) then
      instanceof(Module_element[o],CLASS_Element) 
    else 
      Module_element[o]=0    
    endif);

% backlink is inverse of port
constraint
  forall(m in Objects where instanceof(m,CLASS_Module) /\ (not instanceof(m,CLASS_ModuleV)))
    (exists(f in Objects, s in 1..6 where instanceof(f,CLASS_Element)) (Element_modules_port[f,s]=m));

constraint
  forall(e in Objects, s in 1..6 where instanceof(e,CLASS_Element))
    (let { var OptObjects: module = Element_modules_port[e,s] } in
    (if (module>0) then Module_element[module] = e else true endif));

% Rack_configuration(1,1)<->Configuration_racks(0,100)
array[Objects] of var OptObjects: Rack_configuration;
array[Objects] of var 0..MAXNROFOBJECTS: Configuration_racks_count;
constraint hasAssocLink(CLASS_Rack,1,1,Rack_configuration,CLASS_Configuration,0,100,Configuration_racks_count);

output [
"classnames = \(classnames)\n"
++"otype = \(otype)\n"
++"nrofobjects = \(nrofobjects)\n"
++"Configuration_configtype = \(Configuration_configtype)\n"
++"Element_configuration = \(Element_configuration)\n"
++"Rack_configuration = \(Rack_configuration)\n"
++"Rack_frames_port = \(Rack_frames_port)\n"
++"Frame_rack = \(Frame_rack)\n"
++"Frame_modules_port = \(Frame_modules_port)\n"
++"Module_frame = \(Module_frame)\n"
++"Element_modules_port = \(Element_modules_port)\n"
++"Module_element = \(Module_element)\n"
];
