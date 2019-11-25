clc; close all; clear all;
%constants ...........SI UNITS.........
m = 9295.44;
b = 9.144;
S = 27.87;
cbar= 3.45;
Ix = 12874.8;
Iy = 75673.6;
Iz = 85552.1;
Ixz = 1331.4;
Ixy = 0.0;
Iyz = 0.0;
xcg = 0.3*cbar;
xcgr = 0.35*cbar;
h_E = 216.9;
g = 9.81;
%zt is thrust offset in m
zt = 0.15;


%% initial conditions
XE_0= 0; %m
ZE_0 = -2000; %m {15000 ft}
u_0= 135; %m/s {500 ft/s}
w_0= 0; %m/s
q_0= 0; %rad/s
theta_0= 0*(pi/180);%rad