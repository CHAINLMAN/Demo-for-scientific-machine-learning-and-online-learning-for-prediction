times = 1;
m = 3;
tic
%initial of system parameter
% A = [0.2,0.7,0;0.1,0.3,0.3;0.7,0,0.7];

Ablk = [1,1,0;0,1,1;0,0,0.9];
A = blkdiag(Ablk,Ablk,Ablk);
C1 = [1,0,0];
C = kron(eye(3),C1);

[dimA,~] = size(A);
W = rand(dimA);
W = orth(W);
D1 = eye(3);DD = 0.2*eye(3);
Mid = [D1,DD,DD;DD,D1,DD;DD,DD,D1];
Q = W*Mid*W';
R = eye(3);
% 
% T = 0.2;
% A = [1,T,0;0,1,T;0,0,1];
% Q = diag([T^2,T^2/2,T]);
% R1 = T^2;
% R2 = T^2*eye(m);
% C = eye(m);


% initial of regression parameter
lambda = 1;
beta = 2.5;
Epoh = 7;
Tini = 60;
N = Tini * (power(2,Epoh));
p = ceil(beta * log(N/2));
gamma = 0.6;

%initial of topology parameter
% obtainTopology;
% La = pinv(diag(sum(L,2)))*L;
% fusionStep = 6;
% La = mpower(La,fusionStep);

PerformH = zeros(N-Tini,times);
PerformOri = zeros(N-Tini,times);
PerformScaled = zeros(N-Tini,times);
PerformM = zeros(N-Tini,times);
PerformMScaled = zeros(N-Tini,times);

Gcollect = cell(1,times);

y = zeros(m*times,N);
yhat = zeros(m*times,N);

for i = 1:times
   % x0 = rand(dimA,1);
   x0 = zeros(dimA,1);
   
   [xstate] = Process(A,Q,x0,N);
   % [y1] = observationProcess(xstate,C1,R1);
   [y2] = observationProcess(xstate,C,R);
   y(m*i-m+1:m*i,:) = y2;

   % [yh1,sigma1] = KalmanFilter(A,C1,Q,R1,y1,x0);
   [yh,sigma2] = KalmanFilter(A,C,Q,R,y2,x0);
   yhat(m*i-m+1:m*i,:) = yh;

   [ytil1,G1,Gout1] = OriginalRegressionFilter(y2,beta,lambda,Tini,Epoh);
   [ytil2,G2,Gout2] = RegressionFilter(y2,beta,lambda,Tini,Epoh);
   [ytilreg,G3,Tag3,Tag3R] = RegressionFilterWithForgettingModified(y2,beta,lambda,Tini,Epoh,sigma2);
   [ytilregori,G4,Tag4,Tag4R] = RegressionFilterWithForgetting(y2,beta,lambda,Tini,Epoh,sigma2);

   % PerformH1(1,i) = (y1(Tini+1)-yh1(Tini+1))^2;
   % PerformTil1(1,i) = (y1(Tini+1)-ytil1(Tini+1))^2;

   PerformH(1,i) = norm(y2(:,Tini+1)-yh(:,Tini+1))^2;
   PerformOri(1,i) = norm(y2(:,Tini+1)-ytil1(:,Tini+1))^2;
   PerformM(1,i) = norm(y2(:,Tini+1)-ytil2(:,Tini+1))^2;

   PerformScaled(1,i) = norm(y2(:,Tini+1)-ytilregori(:,Tini+1))^2;
   PerformMScaled(1,i) = norm(y2(:,Tini+1)-ytilreg(:,Tini+1))^2;
   

   for j = 2: N - Tini
    PerformH(j,i) = PerformH(j-1,i) + norm(y2(:,j+Tini)-yh(:,j+Tini))^2;

    PerformOri(j,i) = PerformOri(j-1,i) + norm(y2(:,j+Tini)-ytil1(:,j+Tini))^2;
    PerformM(j,i) = PerformM(j-1,i) + norm(y2(:,j+Tini)-ytil2(:,j+Tini))^2;

    PerformMScaled(j,i) = PerformMScaled(j-1,i) + norm(y2(:,j+Tini)-ytilreg(:,j+Tini))^2;
    PerformScaled(j,i) = PerformScaled(j-1,i) + norm(y2(:,j+Tini)-ytilregori(:,j+Tini))^2;
   end

   Gcollect{1,i} = G2; 
end

PerformanceH = 1/times*sum(PerformH,2);

PerformanceOri = 1/times*sum(PerformOri,2);
PerformanceM = 1/times*sum(PerformM,2);

PerformanceScaled = 1/times*sum(PerformScaled,2);
PerformanceMScaled = 1/times*sum(PerformMScaled,2);

yaverage = 1/times * sum(y(:,Tini+1:N));
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
% y11 = zeros(1,N-Tini);
% y22 = zeros(1,N-Tini);
% y33 = zeros(1,N-Tini);
% for i = 1:times
%     y11 = y11 + y(m*i-m+1,Tini+1:N); 
%     y22 = y22 + y(m*i-m+2,Tini+1:N); 
%     y33 = y33 + y(m*i-m+3,Tini+1:N); 
% end
% plot(tag,1/times*y11,'LineWidth',2);
% hold on
% plot(tag,1/times*y22,'LineWidth',2);
% plot(tag,1/times*y33,'LineWidth',2);

tspan = toc;
% figure(1)
% for i = 1:6
%   subplot(2,3,i)
%   hold on
%   plot(log(tag).^i,PerformanceYtil1-PerformanceYh1)
%   plot(log(tag).^i,PerformanceYtil2-PerformanceYh2)
% plot(log(tag).^i,PerformanceYtil1-PerformanceYtil2)
% end

% tag = 1:1:N-Tini;
% figure(2)
% for i = 1:6
%   subplot(2,3,i)
%   hold on
%   plot(log(tag).^i,PerformanceYtil1-PerformanceYtil2)
%   xlabel(append('log(N)^',num2str(i)))
%   ylabel('Regret')
% end
% 
% figure(3)
% plot(tag,PerformanceYtil1,'LineWidth',2)
% hold on
% plot(tag,PerformanceYh1,'LineWidth',2)
% % plot(tag,PerformanceYtil2,'LineWidth',2)
% plot(tag,PerformanceYh2,'LineWidth',2)
% plot(tag,PerformanceSum,'LineWidth',2)
% xlabel('time step')
% ylabel('Performance')
% 
% figure(4)
% tag = 1:1:N-Tini;
% subplot(1,2,1)
% hold on
% % plot(tag,PerformanceYtil2-PerformanceYh2,'LineWidth',2)
% plot(tag,PerformanceSum-PerformanceYh2,'LineWidth',2)
% plot(tag,PerformanceSub-PerformanceYh2,'LineWidth',2)
% 
% xlabel('time step')
% ylabel('Performance Difference')
% 
% subplot(1,2,2)
% plot(tag,PerformanceYtil2-PerformanceSum,'LineWidth',2)
% 
% 
% G1hat = ComputeG(A,C1,Q,R1,ceil(beta*log(N/2)));
% norm(G1-G1hat)
% G2hat = ComputeG(A,C,Q,R,ceil(beta*log(N/2)));
% norm(G2-G2hat)

% max(eig(Tag1))
% max(eig(Tag2))
% max(eig(Tag3))
% sequence = [];
% for i = 1:ceil(beta*log(N/2))
%      sequence = [sequence,1/(sigma2^(i-1))];
% end
% G3hat = G2hat * kron(diag(sequence),eye(1));
% sequence = [];
% for i = 1:ceil(beta*log(N/2))
%      sequence = [sequence,1/(gamma^(i-1))];
% end
% G4hat = G2hat * kron(diag(sequence),eye(1));
% norm(G2-G2hat)/norm(G2)
% norm(G3-G3hat)/norm(G3)
% norm(G4-G4hat)/norm(G4)
% norm((G2-G2hat)./G2hat)
% norm((G3-G3hat)./G3hat)
% norm((G4-G4hat)./G4hat)
% tspan = toc;
% 
% % biasx = G2hat(1:m,m*(p-1)+1:m*p) * xstate;
% % wholebias = trace(biasx*biasx');
% % maxvalue = max(max(abs(xstate)));
% % 
% % 
% % p = ceil(beta*log(N/2));
% % G2hat(1:3,m*(p-1)+1:m*p) * xstate(:,N)
% % 
% % 
% % figure(10)
% % tag = 1:1:6400;
% % plot(tag,xstate)