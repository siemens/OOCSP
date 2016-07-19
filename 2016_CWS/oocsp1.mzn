% Copyright Siemens AG, 2016
% Authors: Gottfried Schenner / Richard Taupe
% This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

% OOCSP
% Experimental OO to CSP mapping. 
% The aim is to generically map a object oriented model to CSP.
% The schema of the object oriented model is provided as parameters
% The resulting program should be able to enumerate all possible instantiations of the object oriented model within the given scope.
% Additional constraints can be added for finding specificic instantiations
% From the output of the program an object oriented instantiation can be generated
% Variant 1: based on leafclass encoding - 
% every object has a unique id and is instance of a leaf class

include "increasing.mzn";
include "global_cardinality.mzn";

% 
% CLASS HIERACHY
% classnames, leafclass_min, leafclass_max are used to represent class hierachy
% ASSUME THAT ORDER IS DEPTH FIRST LEFT TO RIGHT TRAVERSAL i.e.
%  A       B 
%  A1 A2   B1 
%  A11 A12 B11 B12 B13
%  classnames =    [A  , A1 , A11, A12, A2, B  , B1 , B11, B12 , B13, CLASS_UNUSED]
%  leafclass_min = [A11, A11, A11, A12, A2, B11, B11, B12, B12 , B13, CLASS_UNUSED]
%  leafclass_max =  [A2 , A12, A11, A12, A2, B13, B13, B12, B12, B13, CLASS_UNUSED]
%
% how many classes are there
int : NROFCLASSES;
set of int : CLASSES = 1..CLASS_UNUSED;
% how many objects can be instantiated
int : MAXNROFOBJECTS;
set of int : OBJECTS = 1..MAXNROFOBJECTS;
% reference to object or 0
set of int : OPT_OBJECT = 0..MAXNROFOBJECTS;
% unused objects are of type CLASS_UNUSED
int : CLASS_UNUSED = NROFCLASSES + 1;

array[1..NROFCLASSES] of string: classnames;
array[CLASSES] of var CLASSES : leafclass_min; 
array[CLASSES] of var CLASSES : leafclass_max;
% first possible index for class
array[CLASSES] of var 1..MAXNROFOBJECTS+1 : start;
% nr of instances of class
array[CLASSES] of var 0..MAXNROFOBJECTS : nrofobjects;

% assure that startindizes are ordered
constraint 
  increasing(start) /\ start[1] = 1;

% first objectid is at first leafclass object id
constraint 
  forall(c in CLASSES)
    (start[c] = start[leafclass_min[c]]);

% nrofobjects is the difference between start of first leafclass and start of next leafclass
constraint 
  forall(c in CLASSES)
    (if (c != CLASS_UNUSED) then nrofobjects[c]=start[leafclass_max[c]+1]-start[leafclass_min[c]] else nrofobjects[CLASS_UNUSED] = (MAXNROFOBJECTS + 1) - start[CLASS_UNUSED] endif);

% Object <object> is instanceof <CLASS>
predicate isA(int : CLASS, var int : object) = 
  object >= start[leafclass_min[CLASS]] /\ object < start[leafclass_max[CLASS]+1];

% Predicates for defining the object oriented model and writing constraints
% Attributes are encoded as int arrays of object. if an attribute is not defined for the given object, the value is 0
% Associations currently have two possible encodings:
% link arrays: every object has one link variable, which can either be 0 (for 0/1 assocs or if the association is not definded for this type) or 1..MAXNROFOBJECTS i.e. it "points" to another object. link arrays can only represent 0/1-N associations, for N-M associations link classes must be used or set variables (see below).
% set arrays: every object has one set variable, which contains all associated objects.

% ATTRIBUTES
% defines attribute for class <CLASS>
predicate hasAttribute(int: CLASS, array[OBJECTS] of var int: attributearray, int: min, int: max) =
  forall(i in OBJECTS) (if (isA(CLASS,i)) then (attributearray[i] >= min /\ attributearray[i] <= max) else attributearray[i] = 0 endif);  

% LINKARRAY ASSOCS
% defines N-1 assoc for class <CLASS> to class <LINKCLASS>
predicate hasAssocLink1(int: CLASS, array[OBJECTS] of var OPT_OBJECT: linkarray, int: LINKCLASS) =
  forall(i in OBJECTS) (if (isA(CLASS,i)) then isA(LINKCLASS, linkarray[i]) else linkarray[i] = 0 endif);

% defines N-0/1 assoc for class <CLASS> to class <LINKCLASS>
predicate hasAssocLink01(int: CLASS, array[OBJECTS] of var OPT_OBJECT: linkarray, int: LINKCLASS) =
  forall(i in OBJECTS) (if (isA(CLASS,i)) then linkarray[i]=0 \/ isA(LINKCLASS, linkarray[i]) else linkarray[i] = 0 endif);

% restrict cardinalities for N-1 assoc represented by linkarray
predicate hasAssocCardinality(array[OBJECTS] of var OPT_OBJECT: linkarray,
  array[OBJECTS] of var 0..MAXNROFOBJECTS: counts, 
  int: LINKCLASS,
  int: MINCARD,
  int: MAXCARD) =
  global_cardinality(linkarray,OBJECTS,counts) 
  /\ forall (o in OBJECTS) (if (isA(LINKCLASS,o)) then ((counts[o]>=MINCARD)/\(counts[o]<=min(MAXNROFOBJECTS,MAXCARD))) else counts[o] = 0 endif);

% define N-1 assoc with link
predicate hasAssocLink(int: CLASS1,
  int: MIN1, 
  int: MAX1,
  array[OBJECTS] of var OPT_OBJECT: role1,
  int: CLASS2,
  int: MIN2,
  int: MAX2,
  array[OBJECTS] of var 0..MAXNROFOBJECTS: count_role2, 
) =
  (if (MIN1=0) then hasAssocLink01(CLASS1,role1,CLASS2) else hasAssocLink1(CLASS1,role1,CLASS2) endif) 
  /\ hasAssocCardinality(role1,count_role2,CLASS2,MIN2,MAX2)
  ;

% isA for linkarray assoc
% all objects in the association are instances of <CLASS>
predicate isA(int: object, array[int] of var int: assoc, int: CLASS) = 
  forall(o in OBJECTS) (if (assoc[o] = object) then isA(CLASS,o) else true endif);

% hasNObjects for linkarray assoc
% Object <object> is associated with <min> to <max> objects of the given class in assoc <assoc>
predicate hasNObjects(int: object, array[int] of var int: assoc, int: class, int: min, int: max) = 
  let { var int: nrofobjects = (sum(o in OBJECTS) (assoc[o] = object /\ isA(class,o))) } in
  (nrofobjects >= min /\ nrofobjects <= max);

% SET ASSOCS
% define N-M assoc with set
predicate hasAssocSet(int: CLASS1,
  int: MIN1,
  int: MAX1, 
  array[OBJECTS] of var set of 1..MAXNROFOBJECTS: role1,
  int: CLASS2,
  int: MIN2,
  int: MAX2,
  array[OBJECTS] of var set of 1..MAXNROFOBJECTS: role2, 
  ) = inverseSet(role1,role2) /\ typeAndCardinalitySet(CLASS1,role1,MIN1,MAX1) /\ typeAndCardinalitySet(CLASS2,role2,MIN2,MAX2);

% ensure that the set arrays are inverse to each other
% i.e. if o1 is connected with o2, then o2 is connected to o1 in the inverse role
predicate inverseSet(array[OBJECTS] of var set of 1..MAXNROFOBJECTS: role1,
  array[OBJECTS] of var set of 1..MAXNROFOBJECTS: role2) = 
  (forall(i in OBJECTS) (forall (j in role1[i]) (i in role2[j])) /\
   forall(i in OBJECTS) (forall (j in role2[i]) (i in role1[j])));

% ensure type and cardinality
predicate typeAndCardinalitySet(int: CLASS,array[OBJECTS] of var set of 1..MAXNROFOBJECTS: role, int: MIN, int: MAX) =
  (forall(i in OBJECTS) (if (isA(CLASS,i)) then (card(role[i]) >= MIN) /\ (card(role[i]) <= min(MAXNROFOBJECTS,MAX)) else role[i] = {} endif));
