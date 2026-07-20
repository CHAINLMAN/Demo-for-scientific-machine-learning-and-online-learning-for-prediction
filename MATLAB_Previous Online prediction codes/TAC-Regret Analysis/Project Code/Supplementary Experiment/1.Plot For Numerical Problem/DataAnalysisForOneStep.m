tag = 1:1:N-Tini;
figure(2)
for i = 1:6
  subplot(2,3,i)
  hold on
  plot(log(tag).^i,PerformanceYtil2-PerformanceYh2)
  xlabel(append('log(N)^',num2str(i)))
  ylabel('Regret')
end

figure(3)
for i = 1:6
  subplot(2,3,i)
  hold on
  plot(log(tag).^i,PerformanceSum-PerformanceYh2)
  xlabel(append('log(N)^',num2str(i)))
  ylabel('Regret')
end

% figure(4)
% for i = 1:6
%   subplot(2,3,i)
%   hold on
%   plot(sqrt(tag).^(i/3),PerformanceSum-PerformanceYh2)
%   xlabel(append('log(N)^',num2str(i)))
%   ylabel('Regret')
% end
% 
% 
% figure(5)
% for i = 1:6
%   subplot(2,3,i)
%   hold on
%   plot(sqrt(tag).^(i/3),PerformanceYtil1-PerformanceYh2)
%   xlabel(append('N^(',num2str(i),'/6)'))
%   ylabel('Regret')
% end









figure(6)
subplot(1,2,1)
hold on
plot(tag,PerformanceYtil2-PerformanceYh2,'LineWidth',2)
plot(tag,PerformanceSum-PerformanceYh2,'LineWidth',2)

xlabel('time step')
ylabel('Performance Difference')
legend('Original','Modified')
subplot(1,2,2)
hold on
plot(tag,PerformanceYtil1,'LineWidth',2)
plot(tag,PerformanceYh1,'LineWidth',2)
plot(tag,PerformanceYtil2,'LineWidth',2)
plot(tag,PerformanceYh2,'LineWidth',2)
plot(tag,PerformanceSum,'LineWidth',2)
legend('SP','SO','MP','MO','MM')


region = Tini+1:1:N;
figure(7)
for i = 1:9
  subplot(3,3,i)
  hold on
  cc = exp((log(tag).^(i/2))'./(PerformanceSum-PerformanceYh2));
  plot(tag(Tini+1:N-Tini),cc(Tini+1:N-Tini))
  xlabel(append('log(N)^',num2str((i/2))))
  ylabel('Regret')
end

figure(8)
for i = 1:9
  subplot(3,3,i)
  hold on
  cc = exp((log(tag).^(i/2))'./(PerformanceYtil2-PerformanceYh2));
  plot(tag(Tini+1:N-Tini),cc(Tini+1:N-Tini))
  xlabel(append('log(N)^',num2str((i/2))))
  ylabel('Regret')
end


% figure(8)
% for i = 1:6
%   subplot(2,3,i)
%   hold on
%   plot(sqrt(tag).^(i/3),PerformanceYtil1-PerformanceYh2)
%   xlabel(append('N^(',num2str(i),'/6)'))
%   ylabel('Regret')
% end
