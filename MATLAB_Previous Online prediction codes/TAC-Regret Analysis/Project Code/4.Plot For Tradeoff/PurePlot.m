LW = 6;
LWlabel = 2;
fZ = 38;
fZlegend = 33;
fZlabel = 30;

colorRed = 1/255*[169, 26, 22];
colorSlightRed = 1/255*[248, 220, 230];
colorSlightBlue = 1/255*[219,235,249];
colorSlightPink = 1/255*[250, 227, 210];
colorOrange = 1/255*[207,67,62];
colorSlightYellow = 1/255*[245,224,224];
colorBlue = 1/255*[30, 135, 228];
figure(1)
tag = 1:1:N-Tini;
cc = log(tag).^3;
% plot(tag,URegretOriginal')
hold on

% plot(tag,LRegretOriginal')



% h3 = semilogy(tag(region),AverageOpti(region),'-','Color',colorBlue ,'LineWidth',2.5);
% h2 = semilogy(tag(region),AverageRand(region),'-.','Color',colorRed,'LineWidth',2.5);
% subplot(2,1,1)
yyaxis left
fill([gammaa, fliplr(gammaa)], [lRegression, fliplr(uRegression)],colorSlightBlue,'EdgeColor','none');
hold on
h1 = semilogy(gammaa,mregressionE,'-o','LineWidth',LW);

set(gca, 'YScale', 'log')
ylabel('Regression Error','Interpreter','latex','FontSize',fZ)
hold on 


yyaxis right
fill([gammaa, fliplr(gammaa)], [lRegularization, fliplr(uRegularization)],colorSlightRed,'EdgeColor','none');
hold on

h2 = semilogy(gammaa,mregularizationE,'-or','LineWidth',LW);
ylabel('Regularization Error','Interpreter','latex','FontSize',fZlabel)
ylim([1e-6,max(mregularizationE)])
set(gca, 'YScale', 'log')
grid on

legend([h1,h2],'Regression','Regularization','Interpreter','latex','FontSize',fZlegend)
legend('Location', 'best'); % Set legend position
set(legend, 'Color', 'none')
xlabel('$\gamma$ value','Interpreter','latex','FontSize',fZlabel)
% subplot(2,1,2)

% h3 = semilogy(gammaa,mregressionE+mregularizationE,'-o','LineWidth',2.5);
% grid on
xlim([sigma2,1])



set(gcf, 'Units', 'inches', 'Position', [1, 1, 12, 9]);
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);



% figure(2)
% colormap('jet')
% plot(tag,Accumulation(1,Tini+1:N),'-','LineWidth',2)
% hold on
% plot(tag,Accumulation(9,Tini+1:N),'--','LineWidth',2)
% plot(tag,Accumulation(18,Tini+1:N),'-.','LineWidth',2)
% xlabel('time step','FontSize',15)