LW = 4;
LWlabel = 2;
fZ = 45;
fZlegend = 33;
fZlabel = 30;

colorRed = 1/255*[169, 26, 22];
colorSlightBlue = 1/255*[219,235,249];
colorSlightPink = 1/255*[250, 227, 210];
colorOrange = 1/255*[207,67,62];
colorSlightYellow = 1/255*[245,224,224];
colorBlue = 1/255*[30, 135, 228];

hold on
% plot(y(1,:),y(2,:))
% % plot(y1(1,:),y1(2,:))
% plot(yReg(1,:),yReg(2,:))
% plot(yRegD(1,:),yRegD(2,:))

figure(2)
% semilogy(tag,PerformanceReg-PerformanceKF)
% semilogy(tag,PerformanceRegDelay-PerformanceKF)
% semilogy(tag,PerformanceRegDelayy-PerformanceKF)
% subplot(1,2,1)
hold on
region = Tini:1:N-Tini;
h1 = plot(y(1,Tini+1:N),y(2,Tini+1:N),'-k','LineWidth',LW);
h2 = plot(yReg(1,Tini+1:N),yReg(2,Tini+1:N),'-r','LineWidth',LW/4);
h3 = plot(yRegD(1,Tini+1:N),yRegD(2,Tini+1:N),'-b','LineWidth',LW/4);
grid on
% axis([120,1260,300,1000])
ax = gca; % Get the current axes
ax.GridLineStyle = '--';
% set(gca, 'XTick', 120:60:1260, 'YTick', 300:100:1000)
legend([h1,h2,h3],'Trajectory','Local','Cooperative','Interpreter','latex','Fontsize',fZlegend)
legend('Location', 'best'); % Set legend position
set(legend, 'Color', 'none')
xlabel('x/m','Interpreter','latex','Fontsize',fZ)
ylabel('y/m','Interpreter','latex','Fontsize',fZ)

% set(gcf, 'Color', 'none');
set(gcf, 'Units', 'inches', 'Position', [1, 1, 10, 9]);
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);
