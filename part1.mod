#SETS

set LOCATIONS;
set LEAVING;
set ARRIVING;
set BUSES;

#PARAMETERS

param LOCATION_STUDENTS{k in LOCATIONS};
param BUS_CAPACITY{l in BUSES};
param MOVE_COSTS{k in LOCATIONS,k in LOCATIONS};
param LEAVE_ARRIVE{i in LEAVING,j in ARRIVING};

#VARIABLES

var busroute{LEAVE_ARRIVE[i in LEAVING, j in ARRIVING]} integer, >=0;

#OBJECTIVE FUNCTION

minimize COSTS : sum{busroute[i, j]*MOVE_COSTS[k, k]};

#RESTRICTIONS

#Number of students not greater to bus capacity.				
s.t studentstotal : sum{LOCATION_STUDENTS[k]} <= 2*BUS_CAPACITY['b2'];
s.t students1bus : sum{LOCATION_STUDENTS['s1'],LOCATION_STUDENTS['s2']} <= BUS_CAPACITY['b2'];
s.t students2bus : sum{LOCATION_STUDENTS['s3']} <= BUS_CAPACITY['b2'];
#Number of buses that start is the same as number of buses that end.
s.t numberbuses : sum{LEAVE_ARRIVE['y0',j]} = sum{LEAVE_ARRIVE[i,'x4']};
#Number of routes not greater than number of buses availables.
s.t notgreterroutes : sum{LEAVE_ARRIVE[i,'x4']} <= 3;
#From each stop only 1 route.
s.t stop1{s1} : sum{LEAVE_ARRIVE[i,'x1']} = 1;
s.t stop2{s2} : sum{LEAVE_ARRIVE[i,'x2']} = 1;
s.t stop3{s3} : sum{LEAVE_ARRIVE[i,'x3']} = 1;

data;

#SETS

set LOCATIONS := parking s1 s2 s3 school;
set ARRIVE := x0 x1 x2 x3 x4;
set LEAVING := y0 y1 y2 y3 y4;
set BUSES := b1 b2 b3;

#PARAMETERS

param LOCATION_STUDENTS :=
parking 0
s1 15
s2 5
s3 10
school 0;

param BUS_CAPACITY :=
b1 20
b2 20 
b3 20;

param MOVE_COSTS : parking s1 s2 s3 school :=
parking 0 40 50 50 0
s1 40 0 15 35 30
s2 50 15 0 25 35
s3 50 35 25 0 20
school 0 30 35 20 0;

param LEAVE_ARRIVE : x0 x1 x2 x3 x4:=
y0 0 1 0 1 0
y1 0 0 1 0 0
y2 0 0 0 0 1
y3 0 0 0 0 1
y4 0 0 0 0 0;

end;