function Fth = ThermalForces(Element,Thermal,Node,A,E,alpha,T)

Fth=zeros(2*size(Node,1),1);
n=size(Thermal,1);%number of thermal loads
for i=1:n
    e=Thermal(i,1);%index of element that has thermal load
    
    %number of first and second nodes of element
    node1=Element(e,2);
    node2=Element(e,3);
    %cos and sin of element 
    c=T(1,1,e);
    s=T(1,2,e);
    %transform matrix
    Tthermal=[-c;-s;c;s];
    
    Fth(([node1*2-1 node1*2 node2*2-1 node2*2]))=E(e,2)*...
        A(e,2)*alpha(e,2)*Thermal(i,2)*Tthermal
        +Fth(([node1*2-1  node1*2 node2*2-1 node2*2])) ;
end