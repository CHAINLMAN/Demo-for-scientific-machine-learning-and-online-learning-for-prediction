r = 100;
Pos = setPosition(node,r);%get the position of the sensors
Posi = zeros(2,node);
for i = 1:node
    Posi(:,i) = Pos{1,i};
end
radius = 80;
L = getTopology(node,radius,Posi);
sizee = 40;
figure(1)
hold on
% scatter(Posi(1,1:3),Posi(2,1:3),sizee,'g^','filled')
% scatter(Posi(1,4:6),Posi(2,4:6),sizee,'m^','filled')
scatter(Posi(1,1:node),Posi(2,1:node),sizee,'k^','filled')
for i = 1:node
    for j = 1:node
        if L(i,j) > 0
           plot([Posi(1,i),Posi(1,j)],[Posi(2,i),Posi(2,j)],'b');
        end
    end
end
% scatter(Posi(1,1:3),Posi(2,1:3),sizee,'g^','filled')
% scatter(Posi(1,4:6),Posi(2,4:6),sizee,'m^','filled')
% scatter(Posi(1,7:m),Posi(2,7:m),sizee,'k^','filled')
legend('C^{(1)}','C^{(2)}','C^{(3)}','link')
