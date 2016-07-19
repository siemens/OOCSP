% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

include "../../oocsp.mzn";
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

superclass = [0 ,0 ,CLASS_Element ,CLASS_Element ,CLASS_Element ,CLASS_Element ,0 ,0 ,CLASS_Module ,CLASS_Module ,CLASS_Module ,CLASS_Module ,CLASS_Module ,0 ,CLASS_Rack ,CLASS_Rack];
array[Objects] of var 0..100:Configuration_configtype;
constraint
hasAttribute(CLASS_Configuration,Configuration_configtype,1,100);
% Configuration_racks(0,100)<->Rack_configuration(1,1)
array[Objects] of var set of 1..MAXNROFOBJECTS:Configuration_racks;
array[Objects] of var set of 1..MAXNROFOBJECTS: Rack_configuration;
constraint hasAssocSet(CLASS_Configuration,0,100,Configuration_racks,CLASS_Rack,1,1,Rack_configuration);
% Configuration_elements(0,100)<->Element_configuration(1,1)
array[Objects] of var set of 1..MAXNROFOBJECTS:Configuration_elements;
array[Objects] of var set of 1..MAXNROFOBJECTS: Element_configuration;
constraint hasAssocSet(CLASS_Configuration,0,100,Configuration_elements,CLASS_Element,1,1,Element_configuration);
% Element_modules(0,6)<->Module_element(0,1)
array[Objects] of var set of 1..MAXNROFOBJECTS:Element_modules;
array[Objects] of var set of 1..MAXNROFOBJECTS: Module_element;
constraint hasAssocSet(CLASS_Element,0,6,Element_modules,CLASS_Module,0,1,Module_element);
% Frame_rack(1,1)<->Rack_frames(0,8)
array[Objects] of var set of 1..MAXNROFOBJECTS:Frame_rack;
array[Objects] of var set of 1..MAXNROFOBJECTS: Rack_frames;
constraint hasAssocSet(CLASS_Frame,1,1,Frame_rack,CLASS_Rack,0,8,Rack_frames);
% Frame_modules(0,6)<->Module_frame(1,1)
array[Objects] of var set of 1..MAXNROFOBJECTS:Frame_modules;
array[Objects] of var set of 1..MAXNROFOBJECTS: Module_frame;
constraint hasAssocSet(CLASS_Frame,0,6,Frame_modules,CLASS_Module,1,1,Module_frame);
output [
"classnames = \(classnames)\n"
++"otype = \(otype)\n"
++"nrofobjects = \(nrofobjects)\n"
++"Configuration_configtype = \(Configuration_configtype)\n"
++"Configuration_racks = \(Configuration_racks)\n"
++"Rack_configuration = \(Rack_configuration)\n"
++"Configuration_elements = \(Configuration_elements)\n"
++"Element_configuration = \(Element_configuration)\n"
++"Element_modules = \(Element_modules)\n"
++"Module_element = \(Module_element)\n"
++"Frame_rack = \(Frame_rack)\n"
++"Rack_frames = \(Rack_frames)\n"
++"Frame_modules = \(Frame_modules)\n"
++"Module_frame = \(Module_frame)\n"
];
