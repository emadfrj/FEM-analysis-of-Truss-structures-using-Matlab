% Call this function for analysing the truss stuctures.
%ExcelPath is the path to your excel input file
function [F,strain,stress] = solveTruss(ExcelPath)
clc;

Node=xlsread(ExcelPath,1);
Element=xlsread(ExcelPath,2);
AE=xlsread(ExcelPath,3);
A=AE(:,[1,2]);
E=AE(:,[1,3]);
alpha=AE(:,[1,4]);
angleBC=xlsread(ExcelPath,4);
BC=xlsread(ExcelPath,5);
F=xlsread(ExcelPath,6);
Thermal=xlsread(ExcelPath,7);

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
ElementsNumber = size(Element,1);
deltaL = zeros(ElementsNumber,1);
strain = zeros(ElementsNumber,1);
stress = zeros(ElementsNumber,1);
ForceElement = zeros(ElementsNumber,1);

F=Ka*U; %Forces in bearing nodes
for i=1:ElementsNumber
    q=[U( (2*Element(i,2))-1),U( (2*Element(i,2))),U( (2*Element(i,3))-1),U( (2*Element(i,3)))]' ;
    qq=T(:,:,i)*q;
    deltaL(i)=[-1 1]*qq;
    strain(i)=deltaL(i)/L(i);%strain in each element
    stress(i)=E(i,2)*strain(i);%stress in each element
    ForceElement(i)=A(i,2)*stress(i); %Force in each element
end

Plotting(Node,Element,U,10)
end
    
