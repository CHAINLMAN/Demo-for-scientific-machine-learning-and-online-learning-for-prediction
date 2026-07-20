LW = 8;
LWlabel = 2;
fZ = 45;
fZlegend = 35;
fZlabel = 30;
myColor = [colorSlightBlue;colorSlightPink;colorSlightBlue;colorSlightPink];
tag = 1:1:N-Tini;

figure(2)
hold on
semilogy(tag,PerformanceFogB(:,lgamma)-PerformanceKF,'LineWidth',LW);

for j = 3:lgamma-1

   semilogy(tag,PerformanceFogB(:,lgamma-j+1)-PerformanceKF,'LineWidth',LW);

end
grid on
legend('$\alpha=1$',...
    '$\alpha=0.999$','$\alpha=0.99$','Interpreter','latex','FontSize',fZlegend)
legend('Location', 'best'); % Set legend position
set(legend, 'Color', 'none')
xlabel('Time Step','Interpreter','latex','FontSize',fZlabel)
ylabel('Regret','Interpreter','latex','FontSize',fZlabel)
% axis([1,7500,0,max(PerformanceFogB(:,1)-PerformanceKF)])
set(gcf, 'Units', 'inches', 'Position', [1, 1, 16, 10]);
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);


% inset_position = [0.65, 0.4, 0.25, 0.25]; % [x, y, width, height]
% inset_axes = axes('Position', inset_position);
% 
% % Plot data on the inset axes
% plot(PerformanceFogB(:,lgamma)-PerformanceKF, 'LineWidth', LW); % Inset plot 1
% hold on;
% plot(PerformanceFogB(:,lgamma-1)-PerformanceKF, '--', 'LineWidth', LW); % Inset plot 2
% plot(PerformanceFogB(:,lgamma-2)-PerformanceKF, '--', 'LineWidth', LW); % Inset plot 2
% 
% % Adjust x-axis and y-axis limits for the inset
% xlim(inset_axes, [6500, 7000]);   % Set x-axis range for the inset
% ylim(inset_axes, [11500, 14000]); % Set y-axis range for the inset

% % Label for inset (optional)
% xlabel(inset_axes, 'Zoomed Time Step','Interpreter','latex','FontSize',fZlabel-10);
% ylabel(inset_axes, 'Zoomed Regret','Interpreter','latex','FontSize',fZlabel-10);
% % title(inset_axes, 'Inset');
% legend(inset_axes,'$\alpha=1$','$\alpha=0.9999$','$\alpha=0.999$','Interpreter','latex','FontSize',fZlegend-15)
% legend('Location', 'best'); % Set legend position
% set(legend, 'Color', 'none')

% % Zoomed-in region
% grid on;
