function U=UmakerTruss(n,u,BC,angleBC)
U=zeros(n,2);
%evaluating prescribed deformation
for i=1:size(BC,1)
    U(BC(i,1),1)=BC(i,2);
    if(BC(i,2)==0)
    U(BC(i,1),2)=1;
    else
    U(BC(i,1),2)=2; 
    end
end
%evaluating non-prescribed deformation
ii=1;
for i=1:n
    if(U(i,2)==0)
        U(i,1)=u(ii);
        ii=ii+1;
    end
    if(U(i,2)==2)
        ii=ii+1;
    end
end
%effect of angle Boundary Condition
for i=1:size(angleBC,1)
    U(2*angleBC(i,1)-1,1)=U(2*angleBC(i,1)-1,1)* cos(angleBC(i,2));
    U(2*angleBC(i,1),1)=U(2*angleBC(i,1)-1,1)* sin(angleBC(i,2));
end

U(:,2)=[];



        
    
