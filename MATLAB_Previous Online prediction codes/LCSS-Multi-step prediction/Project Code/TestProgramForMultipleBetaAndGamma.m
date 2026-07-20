times = 50;
m = 3;
tic
%initial of system parameter

% Ablk = [1,1,0;0,1,1;0,0,0.9];
% A = blkdiag(Ablk,Ablk,Ablk);
% C1 = [1,0,0];
% C = kron(eye(3),C1);
% [dimA,~] = size(A);
% W = rand(dimA);
% W = orth(W);
% D1 = eye(3);DD = 0.2*eye(3);
% Mid = [D1,DD,DD;DD,D1,DD;DD,DD,D1];
% Q = W*Mid*W';
% R = eye(3);

%initialization of system parameter
Ablk = [1,1,0;0,1,1;0,0,0.9];
A = kron(eye(m),Ablk);
B1 = [0;0;1];
B = kron(eye(m),B1);
C1 = [1,0,0];
C = kron(eye(m),C1);

[dimA,~] = size(A);
W = rand(dimA);
W = orth(W);
D1 = eye(3*m);
Mid = D1;
Q = 0.01*W*Mid*W';
R = 0.01*eye(m);

%initial of regression parameter
lambda = 1;
beta = 0.8;
% gamma = 0.3:0.05:1;
% numGamma = length(gamma);
Epoh = 5;
Tini = 80;
N = Tini * (power(2,Epoh));
p = ceil(beta * log(N/2));

H = 9;

PerformKF = zeros(times,N-Tini);
PerformReg = cell(1,H);
PerformRegS = cell(1,H);


%collect the regret of different forgetting factor

for i = 1:H
    PerformReg{1,i} = zeros(times,N-Tini);
    PerformRegS{1,i} = zeros(times,N-Tini);
end

PerformanceKF = zeros(1,N-Tini);
PerformanceReg = zeros(H,N-Tini);
PerformanceRegS = zeros(H,N-Tini);


% Gcollect = cell(1,times);

y = zeros(m*times,N);
yhat = zeros(times,N);

for l = 1:H
   
    l

   for i = 1:times
   x0 = rand(dimA,1);
   % x0 = zeros(dimA,1);
   
   [xstate] = Process(A,Q,x0,N);
 
   [y1] = observationProcess(xstate,C,R);

   y(m*(i-1)+1:m*i,:) = y1;

   [yh1,sigma,P,xhat,fedA] = KalmanPredictor(A,C,Q,R,y1,x0,l);

   yhat(m*(i-1)+1:m*i,:) = yh1;

   [yReg] = RegressionFilterWithForgettingModified(y1,beta,lambda,Tini,Epoh,1,l);
   [yRegS] = AutoRegressionFilterWithForgettingModified(y1,beta,lambda,Tini,Epoh,1,l);
   
   %Performance of Kalman Filter
   PKF = PerformanceAnalysis(y1(:,Tini+1:N),yh1(:,Tini+1:N));
   PerformKF(i,:) = PKF;
   
   %Performance of Online Filter (in terms of regret)
   PTemp = PerformanceAnalysis(y1(:,Tini+1:N),yReg(:,Tini+1:N));
   PerformReg{1,l}(i,:) = PTemp - PKF;

   PTemp = PerformanceAnalysis(y1(:,Tini+1:N),yRegS(:,Tini+1:N));
   PerformRegS{1,l}(i,:) = PTemp - PKF;

   end


%take average over different times
 % PerformanceKF = 1/times*sum(PerformKF);
 PerformanceReg(l,:) = 1/times*sum(PerformReg{1,l});
 PerformanceRegS(l,:) = 1/times*sum(PerformRegS{1,l});
 % PerformanceFog1(l,:) = 1/times*sum(PerformForget1{1,l});
 % PerformanceFog2(l,:) = 1/times*sum(PerformForget2{1,l});


end

figure(1)

hold on

tag = 1:1:H;

plot(tag,PerformanceReg(:,N-Tini),LineWidth=5)
plot(tag,PerformanceRegS(:,N-Tini),LineWidth=5)
legend('Direct','Autoregressive Roll Out')
% plot(beta,PerformanceFog1(:,N-Tini))
% plot(beta,PerformanceFog2(:,N-Tini))

figure(2)

hold on

tag = 1:1:N-Tini;
plot(tag,PerformanceReg)
% 
% figure(3)
% hold on
% plot(tag,PerformanceReg(1,:))
% plot(tag,PerformanceReg(2,:))








% figure(1)
% for i = 1:6
%   subplot(2,3,i)
%   hold on
%   plot(log(tag).^i,PerformanceYtil1-PerformanceYh1)
%   plot(log(tag).^i,PerformanceYtil2-PerformanceYh2)
% plot(log(tag).^i,PerformanceYtil1-PerformanceYtil2)
% end

tag = 1:1:N-Tini;
% figure(2)
% for i = 1:6
%   subplot(2,3,i)
%   hold on
%   plot(log(tag).^i,PerformanceReg-PerformanceYtil2)
%   xlabel(append('log(N)^',num2str(i)))
%   ylabel('Regret')
% end

% figure(3)
% % plot(tag,PerformanceYtil1,'LineWidth',2)
% hold on
% plot(tag,PerformanceKF,'LineWidth',2)
% % plot(tag,PerformanceYtil2,'LineWidth',2)
% plot(tag,PerformanceFog1,'LineWidth',2)
% plot(tag,PerformanceFog2,'LineWidth',2)
% plot(tag,PerformanceFogB,'LineWidth',2)
% xlabel('time step')
% ylabel('Performance')
% 
% figure(4)
% tag = 1:1:N-Tini;
% subplot(1,2,1)
% hold on
% % plot(tag,PerformanceYtil2-PerformanceYh2,'LineWidth',2)
% plot(tag,PerformanceReg-PerformanceKF,'LineWidth',2)
% plot(tag,PerformanceFog1-PerformanceKF,'LineWidth',2)
% plot(tag,PerformanceFog2-PerformanceKF,'LineWidth',2)
% 
% xlabel('time step')
% ylabel('Performance Difference')
% 
% subplot(1,2,2)
% hold on
% plot(tag,PerformanceFogB-PerformanceFog1,'LineWidth',2)
% plot(tag,PerformanceFogB-PerformanceReg,'LineWidth',2)
% 
% tspan = toc;
% 
% % G1hat = ComputeG(A,C1,Q,R1,ceil(beta*log(N/2)));
% % norm(G1-G1hat)
% % G2hat = ComputeG(A,C,Q,R,ceil(beta*log(N/2)));
% % norm(G2-G2hat)
% 
% % max(eig(Tag1))
% % max(eig(Tag2))
% % max(eig(Tag3))
% % sequence = [];
% % for i = 1:ceil(beta*log(N/2))
% %      sequence = [sequence,1/(sigma2^(i-1))];
% % end
% % G3hat = G2hat * kron(diag(sequence),eye(1));
% % sequence = [];
% % for i = 1:ceil(beta*log(N/2))
% %      sequence = [sequence,1/(gamma^(i-1))];
% % end
% % G4hat = G2hat * kron(diag(sequence),eye(1));
% % norm(G2-G2hat)/norm(G2)
% % norm(G3-G3hat)/norm(G3)
% % norm(G4-G4hat)/norm(G4)
% % norm((G2-G2hat)./G2hat)
% % norm((G3-G3hat)./G3hat)
% % norm((G4-G4hat)./G4hat)
% % tspan = toc;
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