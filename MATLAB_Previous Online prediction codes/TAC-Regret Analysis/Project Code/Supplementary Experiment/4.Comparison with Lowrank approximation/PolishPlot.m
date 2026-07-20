figure(1)

LW = 5;
LWlabel = 2;
fZ = 35;
fZlegend = 35;
fZlabel = 30;

tag = 1:1:N-Tini;
hold on
plot(tag,PerformanceTil-PerformanceH,'-','LineWidth',LW);
plot(tag,PerformanceFor-PerformanceH,'-','LineWidth',LW)
plot(tag,PerformanceLow-PerformanceH,'--','LineWidth',LW)
grid on

legend('$\gamma=1$','$\gamma=0.6$','Lowrank','Interpreter','latex','FontSize',fZlegend)
xlabel('Time step','Interpreter','latex','FontSize',fZlabel)
ylabel('Regret','Interpreter','latex','FontSize',fZlabel)
set(gcf, 'Units', 'inches', 'Position', [1, 1, 16, 9]);

ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);