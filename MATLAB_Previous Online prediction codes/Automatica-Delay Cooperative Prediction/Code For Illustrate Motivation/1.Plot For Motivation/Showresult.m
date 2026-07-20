close all;clc; clear;

%description

%parameter setting 
width  = 7;     % Width in inches
height = 3;    % Height in inches
alw    = 0.75;    % AxesLineWidth
fsz    = 12;      % Fontsize
lw     = 2;      % LineWidth
msz    = 8;       % MarkerSize

colors = {[0 0.4470 0.7410],[0.8500 0.3250 0.0980],[0.4940 0.1840 0.5560],...
          [0.9290 0.6940 0.1250],[0.4660 0.6740 0.1880],[0.3010 0.7450 0.9330],...
          [1 0 0],[0 0 1],[0 1 0]}; 

y_plot = 0.2;%button position of the plot
h_plot = 0.6;%height of the plot

%datapath  = 'n750r1MC';%G24
datapath = "qp-3";%n100m100dr99
%name     = {'1','2','3'};
r        = 5;

range = 1:1e4;
load(datapath+"-GT.mat");
Out_SBM  = load(datapath+"-BALA.mat");
Out_CGAL = load(datapath+"-CGAL.mat");
%truecost = Out_SBM.res1.sol.itr.pobjval;
truecost = res1.sol.itr.pobjval;

set(gcf, 'Position', [300 100  width*100, height*100]); %<- Set size
subplot(2,2,1);
semilogy(abs(Out_SBM.Out_SBM.PrimalObj(range)-truecost)/abs(truecost));

set(gca, 'Position', [0.15 y_plot 0.3 h_plot]); %<- Set properties
hold on ;
semilogy(abs(Out_CGAL.out.info.primalObj(range)-truecost)/abs(truecost));
xlabel('Iteration','interpreter','latex');

set(gca,'TickLabelInterpreter','latex' ,'FontSize', fsz, 'LineWidth', alw); %<- Set properties
ylabel('$|\mathrm{tr}(C X)-p^\star|/|p^\star|$','interpreter','latex', 'LineWidth', alw,'FontSize', fsz);
xticks([0 2500 5000 7500 1e4]); % Set custom y-tick positions
ax = gca; 
ax.XAxis.Exponent = 3;
%yticks([1e-10 1e-8 1e-6 1e-4 1e-2 1e-0 1e1]); % Set custom y-tick positions
%title('Matrix Completion $$(n = 750)$$','interpreter','latex','FontSize', fsz);
%title('An SDP with $n = m = 100$','interpreter','latex','FontSize', fsz);
%title('SDP-1','interpreter','latex','FontSize', fsz);
title('Shpere-3','interpreter','latex','FontSize', fsz);
%lg = legend( 'BALA','CGAL','interpreter','latex','NumColumns',1,'FontSize', fsz,'Location',"east");
%legend box off;

subplot(2,2,2);
semilogy(Out_SBM.Out_SBM.RelativePFeasi(range));
hold on ;
semilogy(Out_CGAL.out.info.primalFeas(range));
set(gca, 'Position', [0.6 y_plot 0.3 h_plot]); %<- Set properties
xticks([0 2500 5000 7500 1e4]); % Set custom y-tick positions
ax = gca; 
ax.XAxis.Exponent = 3;
%yticks([1e-10 1e-8 1e-6 1e-4 1e-2 1e-0 1e1]); % Set custom y-tick positions

xlabel('Iteration','interpreter','latex');
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fsz, 'LineWidth', alw); %<- Set properties
ylabel('$|\mathcal{A}X-b|/(1+\|b\|)$','interpreter','latex', 'LineWidth', alw,'FontSize', fsz);
title('Shpere-3','interpreter','latex','FontSize', fsz);
%title('SDP-1','interpreter','latex','FontSize', fsz);
%title('Matrix Completion $$(n = 750)$$','interpreter','latex','FontSize', fsz);
%title('An SDP with $n = m = 100$','interpreter','latex','FontSize', fsz);%,'Position',[0.5, 1.2, 0]

%,'Position',[0.115,0.025,0.8,0.1]

%title('Matrix Completion','interpreter','latex','FontSize', fsz);




% 
%print("Numerical-"+datapath,'-depsc','-tiff');