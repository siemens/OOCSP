% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

include "../../oocsp1.mzn";
NROFCLASSES = 8;
classnames = ["Building", "Company", "Device", "PC", "Printer", "Room", "Office", "PrintRoom"];
int : CLASS_Building = 1;
int : CLASS_Building_MIN;
int : CLASS_Building_MAX;
constraint CLASS_Building_MIN <= nrofobjects[CLASS_Building] /\ nrofobjects[CLASS_Building] <= CLASS_Building_MAX;
int : CLASS_Company = 2;
int : CLASS_Company_MIN;
int : CLASS_Company_MAX;
constraint CLASS_Company_MIN <= nrofobjects[CLASS_Company] /\ nrofobjects[CLASS_Company] <= CLASS_Company_MAX;
constraint nrofobjects[CLASS_Company] = 1;
int : CLASS_Device = 3;
int : CLASS_Device_MIN;
int : CLASS_Device_MAX;
constraint CLASS_Device_MIN <= nrofobjects[CLASS_Device] /\ nrofobjects[CLASS_Device] <= CLASS_Device_MAX;
int : CLASS_PC = 4;
int : CLASS_PC_MIN;
int : CLASS_PC_MAX;
constraint CLASS_PC_MIN <= nrofobjects[CLASS_PC] /\ nrofobjects[CLASS_PC] <= CLASS_PC_MAX;
int : CLASS_Printer = 5;
int : CLASS_Printer_MIN;
int : CLASS_Printer_MAX;
constraint CLASS_Printer_MIN <= nrofobjects[CLASS_Printer] /\ nrofobjects[CLASS_Printer] <= CLASS_Printer_MAX;
int : CLASS_Room = 6;
int : CLASS_Room_MIN;
int : CLASS_Room_MAX;
constraint CLASS_Room_MIN <= nrofobjects[CLASS_Room] /\ nrofobjects[CLASS_Room] <= CLASS_Room_MAX;
int : CLASS_Office = 7;
int : CLASS_Office_MIN;
int : CLASS_Office_MAX;
constraint CLASS_Office_MIN <= nrofobjects[CLASS_Office] /\ nrofobjects[CLASS_Office] <= CLASS_Office_MAX;
int : CLASS_PrintRoom = 8;
int : CLASS_PrintRoom_MIN;
int : CLASS_PrintRoom_MAX;
constraint CLASS_PrintRoom_MIN <= nrofobjects[CLASS_PrintRoom] /\ nrofobjects[CLASS_PrintRoom] <= CLASS_PrintRoom_MAX;

leafclass_min = [CLASS_Building, CLASS_Company, CLASS_PC, CLASS_PC, CLASS_Printer, CLASS_Office, CLASS_Office, CLASS_PrintRoom, CLASS_UNUSED];
leafclass_max = [CLASS_Building, CLASS_Company, CLASS_Printer, CLASS_PC, CLASS_Printer, CLASS_PrintRoom, CLASS_Office, CLASS_PrintRoom, CLASS_UNUSED];
% Building_company(1,1)<->Company_buildings(1,10)
array[OBJECTS] of var OPT_OBJECT: Building_company;
array[OBJECTS] of var 0..MAXNROFOBJECTS: Company_buildings_count;
constraint hasAssocLink(CLASS_Building,1,1,Building_company,CLASS_Company,1,10,Company_buildings_count);
% Device_company(1,1)<->Company_devices(1,100)
array[OBJECTS] of var OPT_OBJECT: Device_company;
array[OBJECTS] of var 0..MAXNROFOBJECTS: Company_devices_count;
constraint hasAssocLink(CLASS_Device,1,1,Device_company,CLASS_Company,1,100,Company_devices_count);
% Device_room(1,1)<->Room_devices(0,1000)
array[OBJECTS] of var OPT_OBJECT: Device_room;
array[OBJECTS] of var 0..MAXNROFOBJECTS: Room_devices_count;
constraint hasAssocLink(CLASS_Device,1,1,Device_room,CLASS_Room,0,1000,Room_devices_count);
% Printer_printerBuilding(1,1)<->Building_printers(1,1000)
array[OBJECTS] of var OPT_OBJECT: Printer_printerBuilding;
array[OBJECTS] of var 0..MAXNROFOBJECTS: Building_printers_count;
constraint hasAssocLink(CLASS_Printer,1,1,Printer_printerBuilding,CLASS_Building,1,1000,Building_printers_count);
% Room_building(1,1)<->Building_rooms(2,5)
array[OBJECTS] of var OPT_OBJECT: Room_building;
array[OBJECTS] of var 0..MAXNROFOBJECTS: Building_rooms_count;
constraint hasAssocLink(CLASS_Room,1,1,Room_building,CLASS_Building,2,5,Building_rooms_count);
output [
"classnames = \(classnames)\n"
++"start = \(start)\n"
++"nrofobjects = \(nrofobjects)\n"
++"Building_company = \(Building_company)\n"
++"Device_company = \(Device_company)\n"
++"Device_room = \(Device_room)\n"
++"Printer_printerBuilding = \(Printer_printerBuilding)\n"
++"Room_building = \(Room_building)\n"
];
