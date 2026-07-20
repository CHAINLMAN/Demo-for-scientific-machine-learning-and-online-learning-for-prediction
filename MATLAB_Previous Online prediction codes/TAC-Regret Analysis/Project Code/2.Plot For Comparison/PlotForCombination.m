
figure(2)
subplot(1,2,1)
hold on
region = Tini:1:N-Tini;
fill([tag(region), fliplr(tag(region))], [LRegretOriginal(region)', fliplr(URegretOriginal(region)')],colorSlightPink,'EdgeColor','none');
fill([tag(region), fliplr(tag(region))], [LRegretOptimal(region)', fliplr(URegretOptimal(region)')],colorSlightBlue,'EdgeColor','none');
fill([tag(region), fliplr(tag(region))], [LRegretRand(region)', fliplr(URegretRand(region)')],colorSlightYellow,'EdgeColor','none');
h1 = semilogy(tag(region),AverageOri(region),'-.k','LineWidth',LW);
h3 = semilogy(tag(region),AverageOpti(region),'-','Color',colorBlue ,'LineWidth',LW);
h2 = semilogy(tag(region),AverageRand(region),'-.','Color',colorRed,'LineWidth',LW);
grid on
% axis([120,1260,300,1000])
ax = gca; % Get the current axes
ax.GridLineStyle = '--';
% set(gca, 'XTick', 120:60:1260, 'YTick', 300:100:1000)
legend([h1,h2,h3],'$\gamma=1$','$\gamma=0.6$','$\gamma=\rho(A-LC)$','Interpreter','latex','Fontsize',fZlegend)
xlabel('Time step','Interpreter','latex','Fontsize',fZ)
ylabel('Regret','Interpreter','latex','Fontsize',fZ)

set(gcf, 'Units', 'inches', 'Position', [1, 1, 16, 9]);
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);




LW = 5;
LWlabel = 2;
fZ = 35;
fZlegend = 35;
fZlabel = 30;
myColor = [colorSlightBlue;colorSlightPink;colorSlightOrange;colorSlightRed];
tag = 1:1:7;
figure(2)
subplot(1,2,2)
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
set(gcf, 'Units', 'inches', 'Position', [1, 1, 16, 9]);
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);