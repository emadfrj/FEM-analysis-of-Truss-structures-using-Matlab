% This function calculate the stiffness matrix (k) for each element
% k is a 3 dimentional matrix that its third index is related to element index
function [k,T,L]=K_TrussE(Node,Element,E,A)
n=size(Element,1);%number of Elements
k=zeros(4,4,n);
T=zeros(2,4,n);
L=zeros(n,1);
for i=1:n
    x1=Node(Element(i,2),2);
    y1=Node(Element(i,2),3);
    x2=Node(Element(i,3),2);
    y2=Node(Element(i,3),3);
    
    L(i)=sqrt((x1-x2)^2+(y1-y2)^2);%lenght of element
    c=(x2-x1)/L(i);%Cos of angle of Element
    s=(y2-y1)/L(i);%Sin of angle of Element
    
   
    k(:,:,i)=(1/L(i)*(A(i,2)*E(i,2)))*[c^2 s*c -c^2 -s*c;
        c*s s^2 -c*s -s^2;
        -c^2 -s*c c^2 s*c;
        -c*s -s^2 c*s s^2];%K formula for Truss Element
    
    T(:,:,i)=[c s 0 0 ; 0 0 c s];%transform matrix from q to q'
end
    