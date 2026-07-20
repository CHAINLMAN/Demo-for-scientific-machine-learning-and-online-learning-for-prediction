load('dataStorage.mat')

colorRed = 1/255*[169, 26, 22];
colorSlightBlue = 1/255*[219,235,249];
colorSlightPink = 1/255*[250, 227, 210];
colorOrange = 1/255*[207,67,62];
colorSlightYellow = 1/255*[245,224,224];
colorSlightOrange = 1/255*[255, 246, 236];
colorBlue = 1/255*[30, 135, 228];
LW = 6;
LWlabel = 2;
fZ = 38;
fZlegend = 33;
fZlabel = 30;
myColor = [colorSlightBlue;colorSlightPink;colorSlightOrange;colorSlightPink];
tag = 1:1:7;
figure(2)
for i = 1:4

     MyData = DataStorage{1,i};
     mAccu = MyData(1,:);
     lAccu = MyData(2,:);
     uAccu = MyData(3,:);

     fill([tag, fliplr(tag)], [lAccu, fliplr(uAccu)],myColor(i,:),'EdgeColor','none');
     hold on
     h(i) = semilogy(tag,mAccu,'-o','LineWidth',LW);

end

grid on

legend([h(1),h(2),h(3),h(4)],'$\gamma=\rho(A-LC)$','$\gamma=0.6$',...
    '$\gamma=0.8$','$\gamma=1$','Interpreter','latex','FontSize',fZlegend)
xlabel('Epoch Number','Interpreter','latex','FontSize',fZlabel)
ylabel('Accumulation Error','Interpreter','latex','FontSize',fZlabel)
axis([1,7,0,500])
legend('Location', 'best'); % Set legend position
set(legend, 'Color', 'none')
set(gcf, 'Units', 'inches', 'Position', [1, 1, 12, 9]);
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);
    
set(gca, 'Box', 'off')



