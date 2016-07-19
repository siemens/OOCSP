% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

include "../../oocsp1.mzn";
NROFCLASSES = 16;
classnames = ["Configuration", "Element", "ElementA", "ElementB", "ElementC", "ElementD", "Frame", "Module", "ModuleI", "ModuleII", "ModuleIII", "ModuleIV", "ModuleV", "Rack", "RackDouble", "RackSingle"];
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

leafclass_min = [CLASS_Configuration, CLASS_ElementA, CLASS_ElementA, CLASS_ElementB, CLASS_ElementC, CLASS_ElementD, CLASS_Frame, CLASS_ModuleI, CLASS_ModuleI, CLASS_ModuleII, CLASS_ModuleIII, CLASS_ModuleIV, CLASS_ModuleV, CLASS_RackDouble, CLASS_RackDouble, CLASS_RackSingle, CLASS_UNUSED];
leafclass_max = [CLASS_Configuration, CLASS_ElementD, CLASS_ElementA, CLASS_ElementB, CLASS_ElementC, CLASS_ElementD, CLASS_Frame, CLASS_ModuleV, CLASS_ModuleI, CLASS_ModuleII, CLASS_ModuleIII, CLASS_ModuleIV, CLASS_ModuleV, CLASS_RackSingle, CLASS_RackDouble, CLASS_RackSingle, CLASS_UNUSED];
array[OBJECTS] of var 0..100:Configuration_configtype;
constraint
hasAttribute(CLASS_Configuration,Configuration_configtype,1,100);
% Element_configuration(1,1)<->Configuration_elements(0,100)
array[OBJECTS] of var OPT_OBJECT: Element_configuration;
array[OBJECTS] of var 0..MAXNROFOBJECTS: Configuration_elements_count;
constraint hasAssocLink(CLASS_Element,1,1,Element_configuration,CLASS_Configuration,0,100,Configuration_elements_count);
% Frame_rack(1,1)<->Rack_frames(0,8)
array[OBJECTS] of var OPT_OBJECT: Frame_rack;
array[OBJECTS] of var 0..MAXNROFOBJECTS: Rack_frames_count;
constraint hasAssocLink(CLASS_Frame,1,1,Frame_rack,CLASS_Rack,0,8,Rack_frames_count);
% Module_frame(1,1)<->Frame_modules(0,6)
array[OBJECTS] of var OPT_OBJECT: Module_frame;
array[OBJECTS] of var 0..MAXNROFOBJECTS: Frame_modules_count;
constraint hasAssocLink(CLASS_Module,1,1,Module_frame,CLASS_Frame,0,6,Frame_modules_count);
% Module_element(0,1)<->Element_modules(0,6)
array[OBJECTS] of var OPT_OBJECT: Module_element;
array[OBJECTS] of var 0..MAXNROFOBJECTS: Element_modules_count;
constraint hasAssocLink(CLASS_Module,0,1,Module_element,CLASS_Element,0,6,Element_modules_count);
% Rack_configuration(1,1)<->Configuration_racks(0,100)
array[OBJECTS] of var OPT_OBJECT: Rack_configuration;
array[OBJECTS] of var 0..MAXNROFOBJECTS: Configuration_racks_count;
constraint hasAssocLink(CLASS_Rack,1,1,Rack_configuration,CLASS_Configuration,0,100,Configuration_racks_count);
output [
"classnames = \(classnames)\n"
++"start = \(start)\n"
++"nrofobjects = \(nrofobjects)\n"
++"Configuration_configtype = \(Configuration_configtype)\n"
++"Element_configuration = \(Element_configuration)\n"
++"Frame_rack = \(Frame_rack)\n"
++"Module_frame = \(Module_frame)\n"
++"Module_element = \(Module_element)\n"
++"Rack_configuration = \(Rack_configuration)\n"
];
