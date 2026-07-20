N = 3200;
Tini = 400;
times  = 50;
H = 1;


VarianceOriginal = zeros(1,N-Tini);
VarianceOptimal = zeros(1,N-Tini);
VarianceRandom = zeros(1,N-Tini);
VarianceSupple = zeros(1,N-Tini);
scaling = 1;


LW = 6;
LWlabel = 2;
fZ = 28;
fZlegend = 28;
fZlabel = 28;

RegretOriginal = PerformReg{1,3};
RegretOptimal = PerformReg{1,5};
RegretRandom = PerformReg{1,7};
RegretSupple = PerformReg{1,6};

AverageOri = 1/times * sum(RegretOriginal);
AverageOpti = 1/times * sum(RegretOptimal);
AverageRand = 1/times * sum(RegretRandom);
AverageSupple = 1/times * sum(RegretSupple);

% for i = 1:N-Tini
%     VarianceOriginal(i) = SampleVariance(RegretOriginal(i,:),times);
%     VarianceOptimal(i) = SampleVariance(RegretOptimal(i,:),times);
%     VarianceRandom(i) = SampleVariance(RegretRandom(i,:),times);
% end

for i = 1:N-Tini
    VarianceOriginal(i) = sqrt(var(RegretOriginal(:,i)));
    VarianceOptimal(i) = sqrt(var(RegretOptimal(:,i)));
    VarianceRandom(i) = sqrt(var(RegretRandom(:,i)));
    VarianceSupple(i) = sqrt(var(RegretSupple(:,i)));
end


URegretOriginal = AverageOri + scaling * VarianceOriginal;
LRegretOriginal = AverageOri - scaling * VarianceOriginal;

URegretOptimal = AverageOpti + scaling * VarianceOptimal;
LRegretOptimal = AverageOpti - scaling * VarianceOptimal;

URegretRand = AverageRand + scaling * VarianceRandom;
LRegretRand = AverageRand - scaling * VarianceRandom;

URegretSupple = AverageSupple + scaling * VarianceSupple;
LRegretSupple = AverageSupple - scaling * VarianceSupple;

colorRed = 1/255*[169, 26, 22];
colorSlightBlue = 1/255*[207, 205, 254];
colorSSlightBlue = 1/255*[216, 232, 245];
colorSlightBlack = 1/255*[146,146,146];
colorSlightPink = 1/255*[249, 221, 231];
colorOrange = 1/255*[237, 177, 32];
colorSlightOrange = 1/255*[245,224,224];
colorBlue = 1/255*[30, 135, 228];
colorSlightPurple = 1/255*[230, 230, 250];
colorSlightYellow = 1/255*[246, 237, 206];
colorGreen = 1/255*[0, 255, 3];
colorSlightGreen = 1/255*[205, 255, 203];
% figure(1)
tag = 1:1:N-Tini;
cc = log(tag).^3;
% plot(tag,URegretOriginal')


% plot(tag,LRegretOriginal')

figure(2)
% subplot(1,2,1)
hold on
region = H:1:N-Tini;
fill([tag(region), fliplr(tag(region))], [LRegretOriginal(region), fliplr(URegretOriginal(region))],colorSlightBlack,'EdgeColor','none');
fill([tag(region), fliplr(tag(region))], [LRegretOptimal(region), fliplr(URegretOptimal(region))],colorSlightYellow,'EdgeColor','none');
fill([tag(region), fliplr(tag(region))], [LRegretRand(region), fliplr(URegretRand(region))],colorSSlightBlue,'EdgeColor','none');
fill([tag(region), fliplr(tag(region))], [LRegretSupple(region), fliplr(URegretSupple(region))],colorSlightPink,'EdgeColor','none');


h1 = semilogy(tag(region),AverageOri(region),'-k','LineWidth',LW);
h2 = semilogy(tag(region),AverageOpti(region),':','Color',colorOrange,'LineWidth',LW);
h3 = semilogy(tag(region),AverageRand(region),'--b','LineWidth',LW);
h4 = semilogy(tag(region),AverageSupple(region),'-.r','LineWidth',LW);
grid on
% axis([120,1260,300,1000])
ax = gca; % Get the current axes
ax.GridLineStyle = '--';
% set(gca, 'XTick', 120:60:1260, 'YTick', 300:100:1000)
legend([h1,h2,h4,h3],'$H=2$','$H=4$','$H=5$','$H=6$','Interpreter','latex','Fontsize',fZlegend)
legend('Location', 'best'); % Set legend position
set(legend, 'Color', 'none')
% legend boxoff
xlabel('Time Step','Interpreter','latex','Fontsize',fZ)
ylabel('Regret','Interpreter','latex','Fontsize',fZ)
xlim([0,N-Tini]);

% set(gcf, 'Color', 'none');
set(gcf, 'Units', 'inches', 'Position', [1, 1, 13, 9]);
ax = gca;
ax.Color = 'none';
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);
box on