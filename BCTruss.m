function [K,F]=BCTruss(Node,K,F,BC,angleBC)
d=size(Node,2)-1;%degree of freedom
n=size(BC,1); %number of prescribed deformations

%angle boundary condition
angleN=size(angleBC,1);%number of angle boundary condition
T=eye(size(K,1));
for i=1:angleN
 t = [cos(angleBC(i,2)) sin(angleBC(i,2));-sin(angleBC(i,2)) cos(angleBC(i,2))];
 T([d*angleBC(i,1),d*angleBC(i,1)-1],[d*angleBC(i,1),d*angleBC(i,1)-1])=t;
end
K=T*K*T';

%Penalty opproach for non-zero deformations
BigK= max(K(:));%biggest member of K
B=BigK*1e8;
for i=1:n
    if(BC(i,2)~=0)
        K(BC(i,1),BC(i,1))=K(BC(i,1),BC(i,1))+B;
       F(BC(i,1))=B*BC(i,2);
    end
end


%Elimination for zero deformations
BC=sortrows(BC);%sorting BC according to first column,sorting node nombers
ii=0;
for i=1:n
 if(BC(i,2)==0)
    K(BC(i,1)-ii,:)=[];
    K(:,BC(i,1)-ii)=[];
    F(BC(i,1)-ii)=[];
    ii=ii+1;
 end
 
end
