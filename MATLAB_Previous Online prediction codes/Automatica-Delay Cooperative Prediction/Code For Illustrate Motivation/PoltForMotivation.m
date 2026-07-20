LW = 7;
LWlabel = 2;
fZ = 30;
fZlegend = 30;
fZlabel = 30;
region = 2:21;

scaling = 1.45;
figure(1)
hold on
semilogy(tag,errorLoc,'-^b','LineWidth',LW);
semilogy(tag,errorGlo,'-or','LineWidth',LW-4);

grid on


% colorSlightPink = 1/255*[250, 227, 210];
% fill([flip(ttag), ttag], [Lgaver(region), fliplr(Ugaver(region))], colorSlightBlue,'EdgeColor','none');
% 
% semilogy(flip(ttag),ghat(region),'-^k','LineWidth',LW);
% semilogy(flip(ttag),abs(gg(2,:)),'-ob','LineWidth',2)

xlabel('Recursion step','Interpreter','latex','FontSize',fZ)
ylabel('Prediction Error','Interpreter','latex','FontSize',fZ)
legend('Local Information','Global Information','Interpreter','latex','FontSize',fZlegend)
legend('Location', 'best'); % Set legend position
set(legend, 'Color', 'none')
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);

% axis([1,20,0,1])
% ax = gca;
% ax.FontSize = fZlabel;
% set(gca, 'YScale', 'log');
set(gcf, 'Units', 'inches', 'Position', [1, 1, 12, 7]);

% set(gca, 'Color', 'none'); 
% set(gcf, 'Color', 'none');


