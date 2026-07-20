figure(1)

LW = 5;
LWlabel = 2;
fZ = 35;
fZlegend = 35;
fZlabel = 30;

tag = 1:1:times;
tag = 1 + 0.2 * (tag-1);
semilogy(tag,abs(plotD),'-o','LineWidth',LW);
grid on

legend('Bias','Canceled Bias','Interpreter','latex','FontSize',fZlegend)
xlabel('$\beta$','Interpreter','latex','FontSize',fZlabel)
ylabel('Bias value','Interpreter','latex','FontSize',fZlabel)
set(gcf, 'Units', 'inches', 'Position', [1, 1, 16, 9]);

ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);
% subplot(1,3,1)
% hold on 
% plot(tag,PerformanceOri-PerformanceH,'LineWidth',LW)
% plot(tag,PerformanceScaled-PerformanceH,'LineWidth',LW)
% legend('\gamma=1','\gamma=\rho(A-LC)','FontSize',fZ1)
% xlabel('time step','FontSize',fZ)
% ylabel('Regret','FontSize',fZ)
% grid on
% ax = gca;
% ax.FontSize = fZlabel;
set(gca, 'Box', 'off')