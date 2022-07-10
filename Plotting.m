function Plotting(Node,Element,U,scale)
hold on
axis('equal')
for i = 1:size(Element,1)
    
    
    x1=Node(Element(i,2),2);
    y1=Node(Element(i,2),3);
    x2=Node(Element(i,3),2);
    y2=Node(Element(i,3),3);
    u1=scale*U(2*Element(i,2)-1);
    u2=scale*U(2*Element(i,3)-1);
    v1=scale*U(2*Element(i,2));
    v2=scale*U(2*Element(i,3));
    plot([x1 x2],[y1 y2],'b')
    plot([x1+u1  x2+u2],[y1+v1  y2+v2],'r')
   
end
legend('Undeformed structure','Deformed structure')
title(['Enlarging scale = ',num2str(scale)]);