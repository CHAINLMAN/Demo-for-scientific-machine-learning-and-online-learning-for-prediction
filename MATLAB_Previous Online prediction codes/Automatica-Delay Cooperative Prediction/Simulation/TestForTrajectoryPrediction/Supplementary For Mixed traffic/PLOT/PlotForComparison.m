LW = 4;
LWlabel = 2;
fZ = 45;
fZlegend = 37;
fZlabel = 30;

colorRed = 1/255*[169, 26, 22];
colorSlightBlue = 1/255*[219,235,249];
colorSlightPink = 1/255*[250, 227, 210];
colorOrange = 1/255*[207,67,62];
colorSlightYellow = 1/255*[245,224,224];
colorBlue = 1/255*[30, 135, 228];

hold on
plot(y(1,:),y(2,:))
% plot(y1(1,:),y1(2,:))
plot(yReg(1,:),yReg(2,:))
plot(yRegD(1,:),yRegD(2,:))


figure(2)
plot(tag,-PerformanceReg(1:N-Tini)+PerformanceFog1(1:N-Tini))
plot(tag,-PerformanceReg(1:N-Tini)+PerformanceFog2(1:N-Tini))
plot(tag,-PerformanceReg(1:N-Tini)+PerformanceFog3(1:N-Tini))
hold on
region = Tini:1:N-Tini;
h1 = plot(tag,-PerformanceReg(1:N-Tini)+PerformanceFog1(1:N-Tini),'-k','LineWidth',LW);
h2 = plot(tag,-PerformanceReg(1:N-Tini)+PerformanceFog2(1:N-Tini),'-r','LineWidth',LW);
h3 = plot(tag,-PerformanceReg(1:N-Tini)+PerformanceFog3(1:N-Tini),'-b','LineWidth',LW);
grid on
% axis([120,1260,300,1000])
ax = gca; % Get the current axes
ax.GridLineStyle = '--';
% set(gca, 'XTick', 120:60:1260, 'YTick', 300:100:1000)
legend([h1,h2,h3],'d=1','d=2','d=4','Interpreter','latex','Fontsize',fZlegend)
legend('Location', 'best'); % Set legend position
set(legend, 'Color', 'none')
xlabel('Time Step','Interpreter','latex','Fontsize',fZ)
ylabel('Gap','Interpreter','latex','Fontsize',fZ)

% set(gcf, 'Color', 'none');
set(gcf, 'Units', 'inches', 'Position', [1, 1, 10, 9]);
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);
