% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

% Office has at 1..8 PC
constraint
  forall (o in OBJECTS where isA(CLASS_Office,o)) (hasNObjects(o,Device_room,CLASS_PC,1,8));

% Office has at most 1 Printer
constraint
  forall (o in OBJECTS where isA(CLASS_Office,o)) (hasNObjects(o,Device_room,CLASS_Printer,0,1));

% PrintRoom has exactly 1 Printer
constraint
  forall (o in OBJECTS where isA(CLASS_PrintRoom,o)) (hasNObjects(o,Device_room,CLASS_Printer,1,1));

% PrintRoom has no PC
constraint
  forall (o in OBJECTS where isA(CLASS_PrintRoom,o)) (hasNObjects(o,Device_room,CLASS_PC,0,0));

bool: USECARDINALITYCONSTRAINTS;

constraint
if USECARDINALITYCONSTRAINTS then
% manual: theorem 4
% (6)
% (7)
1*nrofobjects[CLASS_Device] <= 1*nrofobjects[CLASS_Office] + 8*nrofobjects[CLASS_Office] + 1*nrofobjects[CLASS_PrintRoom] + 0*nrofobjects[CLASS_PrintRoom] /\ % (8)
1*nrofobjects[CLASS_Device] <= 1*nrofobjects[CLASS_Printer] + 1*nrofobjects[CLASS_Printer] + 1*nrofobjects[CLASS_PC] + 0*nrofobjects[CLASS_PC] /\ % (9)
% (10)
0*nrofobjects[CLASS_Office] + 1*nrofobjects[CLASS_Office] + 1*nrofobjects[CLASS_PrintRoom] + 0*nrofobjects[CLASS_PrintRoom] <= 1*nrofobjects[CLASS_Device] /\ % (11)
% (12)
0*nrofobjects[CLASS_Printer] + 0*nrofobjects[CLASS_Printer] + 1*nrofobjects[CLASS_PC] + 0*nrofobjects[CLASS_PC] <= 1*nrofobjects[CLASS_Device] /\ % (13)

% manual: theorem 5
% A' = Printer:
1*nrofobjects[CLASS_Printer] <= 1*nrofobjects[CLASS_Room] /\ % (14)
% (16)
% A' = PC:
1*nrofobjects[CLASS_PC] <= 8*nrofobjects[CLASS_Room] /\ % (14)
% (16)
% B' = Office:
% (15)
% (17)
% B' = PrintRoom:
% (15)
% (17)

% generated:
1*nrofobjects[CLASS_Printer] + -1*nrofobjects[CLASS_Device] <= 0 /\
1*nrofobjects[CLASS_Company] + -1*nrofobjects[CLASS_Device] <= 0 /\
1*nrofobjects[CLASS_Office] + -1*nrofobjects[CLASS_Room] <= 0 /\
1*nrofobjects[CLASS_Company] + -1*nrofobjects[CLASS_Building] <= 0 /\
5*nrofobjects[CLASS_Building] + -1*nrofobjects[CLASS_PrintRoom] + -1*nrofobjects[CLASS_Office] >= 0 /\
1*nrofobjects[CLASS_Building] + -10*nrofobjects[CLASS_Company] <= 0 /\
1*nrofobjects[CLASS_Office] + 1*nrofobjects[CLASS_PrintRoom] + -1*nrofobjects[CLASS_Room] = 0 /\
1*nrofobjects[CLASS_Room] + -5*nrofobjects[CLASS_Building] <= 0 /\
1*nrofobjects[CLASS_Building] + -1*nrofobjects[CLASS_Printer] <= 0 /\
1*nrofobjects[CLASS_PrintRoom] + -1*nrofobjects[CLASS_Room] <= 0 /\
0*nrofobjects[CLASS_Room] + -1*nrofobjects[CLASS_Device] <= 0 /\
100*nrofobjects[CLASS_Company] + -1*nrofobjects[CLASS_PC] + -1*nrofobjects[CLASS_Printer] >= 0 /\
1*nrofobjects[CLASS_PC] + -1*nrofobjects[CLASS_Device] <= 0 /\
2*nrofobjects[CLASS_Building] + -1*nrofobjects[CLASS_Room] <= 0 /\
0*nrofobjects[CLASS_Room] + -1*nrofobjects[CLASS_Printer] + -1*nrofobjects[CLASS_PC] <= 0 /\
2*nrofobjects[CLASS_Building] + -1*nrofobjects[CLASS_PrintRoom] + -1*nrofobjects[CLASS_Office] <= 0 /\
0*nrofobjects[CLASS_Room] + -1*nrofobjects[CLASS_PrintRoom] <= 0 /\
1*nrofobjects[CLASS_Company] + -1*nrofobjects[CLASS_Printer] + -1*nrofobjects[CLASS_PC] <= 0 /\
0*nrofobjects[CLASS_Room] + -1*nrofobjects[CLASS_Office] <= 0 /\
1*nrofobjects[CLASS_Device] + -100*nrofobjects[CLASS_Company] <= 0 /\
1*nrofobjects[CLASS_Printer] + 1*nrofobjects[CLASS_PC] + -1*nrofobjects[CLASS_Device] = 0 /\
1*nrofobjects[CLASS_Company] <= 1 /\
0*nrofobjects[CLASS_Device] + -1*nrofobjects[CLASS_Printer] <= 0 /\
1*nrofobjects[CLASS_Company] >= 1 /\
0*nrofobjects[CLASS_Device] + -1*nrofobjects[CLASS_PC] <= 0 /\
1*nrofobjects[CLASS_Device] + 0*nrofobjects[CLASS_Office] + 0*nrofobjects[CLASS_PrintRoom] >= 0
else
true
endif;
