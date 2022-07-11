% This function calculate the global stiffness matrix (K) for all elements
% K is a 2 dimentional matrix. By solving the equation of KU=F the displacements of 
% each nodes(U) can be calculated
function K=assemble(Node,Element,k)
d=size(Node,2)-1; %degree of freedom
n=size(Element,1);%number of elements
K=zeros(d*size(Node,1),d*size(Node,1)); %K assembled
% fjgfhfj

for i=1:n
   ne = Element(i,1);% number of nodes in element
   nod=zeros(ne,1);
   for j=2:ne+1
        nod(j-1)=(d*Element(i,j));%Places of displacements in Global U according to this Element's Nodes
   end
   r=zeros(d*(ne),1);
   for z=1:ne
       r(d*(z-1)+1:d*z) = nod(z)-d+1:1:nod(z);
   end
   r=r';
   
   K(r,r)=K(r,r)+k(:,:,i);
    
end

