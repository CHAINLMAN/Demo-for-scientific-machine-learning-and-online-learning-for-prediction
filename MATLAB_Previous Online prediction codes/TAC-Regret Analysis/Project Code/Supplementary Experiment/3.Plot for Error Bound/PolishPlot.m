figure(1)

hold on
% plot(tag,detV);
% plot(tag,HWbound);
% plot(tag,regular);
tag = 1:1:Epoh;
LW = 5;
LWlabel = 2;
fZ = 35;
fZlegend = 35;
fZlabel = 30;


semilogy(tag,detV,'-o','LineWidth',LW);
semilogy(tag,HWbound,'-o','LineWidth',LW);
semilogy(tag,regular,'-o','LineWidth',LW);
grid on
legend('DetBound','HWbound','Real','Interpreter','latex','FontSize',fZlegend)
xlabel('Epoch number','Interpreter','latex','FontSize',fZ)
ylabel('Regression value','Interpreter','latex','FontSize',fZ)
grid on
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);
set(gcf, 'Units', 'inches', 'Position', [1, 1, 16, 9]);
axis([1,9,0,6000])

% figure(1)
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