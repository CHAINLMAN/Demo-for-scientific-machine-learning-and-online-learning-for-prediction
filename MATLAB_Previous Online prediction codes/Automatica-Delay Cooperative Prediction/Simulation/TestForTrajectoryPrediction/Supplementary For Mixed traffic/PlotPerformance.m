LW = 3;
LWlabel = 2;
fZ = 45;
fZlegend = 35;
fZlabel = 30;
% myColor = [colorSlightBlue;colorSlightPink;colorSlightBlue;colorSlightPink];


figure(4)
hold on
tag = Tini+1:1:N-5;

plot(tag,PerformanceReg(1:N-Tini-5),'LineWidth',LW)

plot(tag,PerformanceFog1(1:N-Tini-5),'LineWidth',LW)

plot(tag,PerformanceFog2(1:N-Tini-5),'LineWidth',LW)


grid on
legend('$\gamma = 1$',...
    '$\gamma=0.8$','$\gamma=0.6$','Interpreter','latex','FontSize',fZlegend)
legend('Location', 'best'); % Set legend position
set(legend, 'Color', 'none')
title('Accumulation of Prediction Error','Interpreter','latex','FontSize',fZlabel)
xlabel('Time step','Interpreter','latex','FontSize',fZlabel)
ylabel('Error ($m^2$)','Interpreter','latex','FontSize',fZlabel)
% axis([1,7500,0,max(PerformanceFogB(:,1)-PerformanceKF)])
set(gcf, 'Units', 'inches', 'Position', [1, 1, 16, 16]);
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);


% inset_position = [0.18, 0.25, 0.25, 0.35]; % [x, y, width, height]
% inset_axes = axes('Position', inset_position);
% 
% % Plot data on the inset axes
% 
% hold on;
% plot(y1(1,:),y1(2,:),'LineWidth',LW)
% 
% plot(yReg(1,:),yReg(2,:),'LineWidth',LW)
% 
% plot(yFog1(1,:),yFog1(2,:),'LineWidth',LW)
% 
% plot(yFog2(1,:),yFog2(2,:),'LineWidth',LW)
% 
% % Adjust x-axis and y-axis limits for the inset
% xlim(inset_axes, [4, 7]);   % Set x-axis range for the inset
% ylim(inset_axes, [200, 400]); % Set y-axis range for the inset
% 
% % Label for inset (optional)
% xlabel(inset_axes, 'x/m','Interpreter','latex','FontSize',fZlabel-10);
% ylabel(inset_axes, 'y/m','Interpreter','latex','FontSize',fZlabel-10);
% % title(inset_axes, 'Inset');
% % legend(inset_axes,'$\alpha=1$','$\alpha=0.9999$','$\alpha=0.999$','Interpreter','latex','FontSize',fZlegend-15)
% % legend('Location', 'best'); % Set legend position
% % set(legend, 'Color', 'none')
% 
% % Zoomed-in region
% grid on;
