tag = 1:1:N-Tini;

LW = 5;
LWlabel = 2;

N = 6400;
fZ = 16;
fZ1 = 16;
fZlabel = 16;
fZlegend = 16;

region = N/2:1:N-Tini;
tag = Tini+1:1:6400;
figure(7)
% for i = 1:9
%   subplot(3,3,i)
%   hold on
%   grid on
% 
%   diff = PerformanceM-PerformanceH;
%   cc1 = diff(region)./(log(region).^(i/2))';
%   plot(region,cc1,'LineWidth',LW)
% 
%   diff = PerformanceMScaled-PerformanceH;
%   cc2 = diff(region)./(log(region).^(i/2))';
%   plot(region,cc2,'LineWidth',LW)
% 
%   axis([N/2,N-Tini,0.5*min(cc2),1.5*max(cc1)])
%   Sstring  = append('$\log(N)^','{',num2str((i/2)),'}$');
%   xlabel(Sstring,'Interpreter','latex','FontSize',fZ)
%   ylabel('Index','Interpreter','latex','FontSize',fZ)
%   legend('Original','Modified','Interpreter','latex','FontSize',fZ1)
% 
%   ax = gca;
%   ax.FontSize = fZlabel;
% end

for i = 1:3
  subplot(1,3,i)
  hold on
  grid on

  diff = PerformanceM-PerformanceH;
  cc1 = diff(region)./(log(region).^(i))';
  plot(region,cc1,'LineWidth',LW)

  diff = PerformanceMScaled-PerformanceH;
  cc2 = diff(region)./(log(region).^(i))';
  plot(region,cc2,'LineWidth',LW)

  axis([N/2,N-Tini,0.5*min(cc2),1.5*max(cc1)])
  Sstring  = append('$\log^','{',num2str(i),'}$','(N)');
  xlabel(Sstring,'Interpreter','latex','FontSize',fZ)
  ylabel('Index','Interpreter','latex','FontSize',fZ)
  legend('Original','Modified','Interpreter','latex','FontSize',fZ1)

  ax = gca;
  ax.FontSize = fZlabel;
end


set(gcf, 'Units', 'inches', 'Position', [1, 1, 10, 5]);
ax = gca;
ax.FontSize = fZlabel;
set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);

