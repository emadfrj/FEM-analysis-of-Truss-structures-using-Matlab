clc;clear all;close all

Node=xlsread('Truss(a).xlsx',1);
Element=xlsread('Truss(a).xlsx',2);
AE=xlsread('Truss(a).xlsx',3);
A=AE(:,[1,2]);
E=AE(:,[1,3]);
alpha=AE(:,[1,4]);
angleBC=xlsread('Truss(a).xlsx',4);
BC=xlsread('Truss(a).xlsx',5);
F=xlsread('Truss(a).xlsx',6);
Thermal=xlsread('Truss(a).xlsx',7);

%making K assembled
[k,T,L]=K_TrussE(Node,Element,E,A);
Ka=assemble(Node,Element,k);
%thermal effect
Fth = ThermalForces(Element,Thermal,Node,A,E,alpha,T);
F=F+Fth;
%Boundary condition effects
[Kr,Fr]=BCTruss(Node,Ka,F,BC,angleBC);
%solving equgation
u=Kr\Fr;
%making completed U
n = size(Ka,1);
U=UmakerTruss(n,u,BC,angleBC);

%post processing
F=Ka*U;
ElementNumber = size(Element,1);
deltaL = zeros(ElementNumber,1);
strain = zeros(ElementNumber,1);
stress = zeros(ElementNumber,1);
ForceElement = zeros(ElementNumber,1);
for i=1:ElementNumber
    q=[U( (2*Element(i,2))-1),U( (2*Element(i,2))),U( (2*Element(i,3))-1),U( (2*Element(i,3)))]' ;
    qq=T(:,:,i)*q;
    deltaL(i)=[-1 1]*qq;
    strain(i)=deltaL(i)/L(i);
    stress(i)=E(i,2)*strain(i);
    ForceElement(i)=A(i,2)*stress(i);
end

Plotting(Node,Element,U,10)
    
