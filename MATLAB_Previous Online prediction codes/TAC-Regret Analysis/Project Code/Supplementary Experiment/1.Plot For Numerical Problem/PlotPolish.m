tag = 1:1:N-Tini;

LW = 5;
LWlabel = 2;
fZ = 35;
fZlegend = 30;
fZlabel = 30;

figure(1)
subplot(1,3,1)
hold on 
plot(tag,PerformanceOri-PerformanceH,'LineWidth',LW)
plot(tag,PerformanceScaled-PerformanceH,'LineWidth',LW)

legend('$\gamma=1$','$\gamma=\rho(A-LC)$','Interpreter','latex','FontSize',fZlegend)
legend('Location', 'best'); % Set legend position
set(legend, 'Color', 'none')
xlabel('Time Step','Interpreter','latex','FontSize',fZ)
ylabel('Regret','Interpreter','latex','FontSize',fZ)
grid on
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);

subplot(1,3,2)
hold on
plot(tag,PerformanceM-PerformanceH,'LineWidth',LW)
plot(tag,PerformanceMScaled-PerformanceH,'LineWidth',LW)
legend('$\gamma=1$','$\gamma=\rho(A-LC)$','Interpreter','latex','FontSize',fZlegend)
legend('Location', 'best'); % Set legend position
set(legend, 'Color', 'none')
xlabel('Time Step','Interpreter','latex','FontSize',fZ)
ylabel('Regret','Interpreter','latex','FontSize',fZ)
grid on
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);

subplot(1,3,3)
y11 = zeros(1,N-Tini);
y22 = zeros(1,N-Tini);
y33 = zeros(1,N-Tini);
for i = 1:times
    y11 = y11 + y(m*i-m+1,Tini+1:N); 
    y22 = y22 + y(m*i-m+2,Tini+1:N); 
    y33 = y33 + y(m*i-m+3,Tini+1:N); 
end
plot(tag,1/times*y11,'LineWidth',LW);
hold on
plot(tag,1/times*y22,'LineWidth',LW);
plot(tag,1/times*y33,'LineWidth',LW);

legend('y1','y2','y3','Interpreter','latex','FontSize',fZlegend)
legend('Location', 'best'); % Set legend position
set(legend, 'Color', 'none')
xlabel('Time Step','Interpreter','latex','FontSize',fZ)
ylabel('Observation','Interpreter','latex','FontSize',fZ)
grid on
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);

set(gcf, 'Units', 'inches', 'Position', [1, 1, 32, 8]);

% tag = 1:1:N-Tini;
% figure(1)
% subplot(1,3,1)
% hold on 
% plot(tag,PerformanceOri-PerformanceH,'LineWidth',2)
% plot(tag,PerformanceScaled-PerformanceH,'LineWidth',2)
% subplot(1,3,2)
% hold on
% plot(tag,PerformanceM-PerformanceH,'LineWidth',2)
% plot(tag,PerformanceMScaled-PerformanceH,'LineWidth',2)
% subplot(1,3,3)
