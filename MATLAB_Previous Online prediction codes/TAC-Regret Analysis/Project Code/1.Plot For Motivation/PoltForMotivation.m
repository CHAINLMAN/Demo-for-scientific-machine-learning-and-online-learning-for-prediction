p = ceil(beta*log(N/2));

ttag = 1:1:p-1;

Ghat = ComputeG(A,C,Q,R,p);

ghat = ComputeNorm(Ghat,m,p);

LW = 5;
LWlabel = 2;
fZ = 30;
fZlegend = 30;
fZlabel = 30;
region = 2:21;

scaling = 1.45;
hold on
h1 = semilogy(flip(ttag),ghat(region),'-^k','LineWidth',LW);


grid on


gg = zeros(times,p);

for i = 1:times
    gg(i,:) = ComputeNorm(Gcollect{1,i},m,p);
end

VarianceGG = zeros(1,p);
for i = 1:p
    VarianceGG(i) = sqrt(var(gg(:,i)));
end



gaver = 1/times*sum(gg);
Ugaver = gaver +  scaling * VarianceGG;
Lgaver = gaver -  scaling * VarianceGG;

colorSlightPink = 1/255*[250, 227, 210];
fill([flip(ttag), ttag], [Lgaver(region), fliplr(Ugaver(region))], colorSlightBlue,'EdgeColor','none');

semilogy(flip(ttag),ghat(region),'-^k','LineWidth',LW);

h3 = semilogy(flip(ttag),gaver(region),'-ob','LineWidth',LW);
% semilogy(flip(ttag),abs(gg(2,:)),'-ob','LineWidth',2)

xlabel('Block index','Interpreter','latex','FontSize',fZ)
ylabel('Block norm','Interpreter','latex','FontSize',fZ)
legend([h1,h3],'Ground Truth','Estimated model','Interpreter','latex','FontSize',fZlegend)
legend('Location', 'best'); % Set legend position
set(legend, 'Color', 'none')
axis([1,20,0,1])
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);
set(gca, 'YScale', 'log');
set(gcf, 'Units', 'inches', 'Position', [1, 1, 12, 7]);

set(gca, 'Color', 'none'); 
% set(gcf, 'Color', 'none');


