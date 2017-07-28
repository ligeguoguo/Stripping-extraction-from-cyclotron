%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This test script is used for calculation of the stripping extraction from the superconductiong
%cyclotron in INFN-LNS
%Lige Zhang (2017) zhanglige@hust.edu.cn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%Calculate the closed orbit and the extraction orbit for single particle%%%%%%%%%%%%%%%%%%%%%%%%%
a=load('./O 65AMeV MEASURED.mat');
Bz=a.BZMES(1:120,:)*1E3;      %%%%load the map in form of 120*235 in r-theta coordinate

AI=17.9992;                   %%%%Particle before stripping
QI=6;
AT=17.9992;                   %%%%Particle after stripping
QT=8;
E=65;                         %%%% Energy (MeV)
gama=(E+938.27203)/938.27203; 

SingleParticleExtraction;

%plot(-s_orbit(:,1),-s_orbit(:,3)); %%%%Plot the extraction orbit

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%Calculate the map of the magnetic channnel%%%%%%%%%%%%%%%%%%%%%%%%%

MC1THETA0=80;
MC1THETA1=86;
MC2THETA0=104;
MC2THETA1=114;                   %%%%Positon of the 2 magnetic channel

MC1G=1.8;                   %%%%Gradient of magnetic channel 1
MC1D=0;                     %%%%Gradient of magnetic channel 1
MC2G=1.8;                   %%%%Gradient of magnetic channel 2
MC2D=0;                     %%%%Gradient of magnetic channel 1

MCFiled;
SingleParticleExtraction;   %%%%Adjust the extraction orbit
MCFiled;                    %%%%Adjust the MC map

%mesh(px,py,mcall);          %%%%Plot the map of the MCs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Calculate the envelopes%%%%%%%%%%%%%%%%%%%%%%%%%
alphar=-0.533862;
betar=1.303566;
emmitdefr=2;                     %%%%beam parameters in r-r' 

alphaz=0.219913;
betaz=0.66831;
emmitdefz=1;                     %%%%beam parameters in z-z' 

envelop_rz;

plot(0:s/9998:s,max(envz,[],1));
hold on
plot(0:s/9998:s,max(envr,[],1),'r');
hold on
plot(0:s/9998:s,min(envr,[],1),'r');
hold on
plot(0:s/9998:s,min(envz,[],1)); %%%%Plot envelopes

