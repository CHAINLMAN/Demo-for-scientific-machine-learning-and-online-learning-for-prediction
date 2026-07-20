times = 5;
m = 2;
tic
node = 6;

A = [0.4,0.6;0.8,0.2];
C = [1,0];
Ca = [0,1;1,-1];

% Ca(3) = -1;

[dimA,~] = size(A);
% W = rand(dimA);
% W = orth(W);
% D1 = 100 * diag(rand(1,dimA));
% Mid = D1;
% Q = W*Mid*W';
Q = [50,-10;-10,50];

R = 1;
Ra = 1*eye(2);

C*dare(A',C',Q,R)*C' + R
C*dare(A',[C;Ca]',Q,blkdiag(R,Ra))*C' + R
%initial of regression parameter
lambda = 1;
beta = 0.6;
% gamma = 0.3:0.05:1;
% numGamma = length(gamma);
Epoh = 9;
Tini = 30;
N = Tini * (power(2,Epoh));
p = ceil(beta * log(N/2));

H = 1;

PerformKF = zeros(times,N-Tini);
PerformDKF = zeros(times,N-Tini);
PerformReg = cell(1,H);
PerformRegDelay = cell(1,H);
PerformRegCross = cell(1,H);

for i = 1:H
    PerformReg{1,i} = zeros(times,N-Tini);
    PerformRegDelay{1,i} = zeros(times,N-Tini);
    PerformRegCross{1,i} = zeros(times,N-Tini);
end

PerformanceKF = zeros(1,N-Tini);

PerformanceDKF = zeros(1,N-Tini);

PerformanceReg = zeros(H,N-Tini);

PerformanceRegDelay = zeros(H,N-Tini);

PerformanceRegCross = zeros(H,N-Tini);

y = zeros(m*times,N);

yaug = zeros(m*times,N);

yhat = zeros(m*times,N);

ydhat = zeros(m*times,N);

for l = 1:H
   
   for i = 1:times
       
   i

   x0 = rand(dimA,1);
   
   [xstate] = Process(A,Q,x0,N);
 
   [y1] = observationProcess(xstate,C,R);

   [y2] = observationProcess(xstate,Ca,Ra);

   % y(m*(i-1)+1:m*i,:) = y1;
   % 
   % yaug(m*(i-1)+1:m*i,:) = y2;

   [yh1] = KalmanPredictor(A,C,Q,R,y1,x0);

   [yhd1] = KalmanDelayedPredictor(A,C,Ca,Q,R,Ra,y1,y2,x0,l);

   % yhat(m*(i-1)+1:m*i,:) = yh1;
   % 
   % ydhat(m*(i-1)+1:m*i,:) = yhd1;

   [yReg] = RegressionFilterWithForgettingModified(y1,beta,lambda,Tini,Epoh,1);
  
   [yRegDelay] = RegressionFilterWithDelay(y1,y2,beta,lambda,Tini,Epoh,1,l);
  
   %Performance of Kalman Filter
   PKF = PerformanceAnalysis(y1(:,Tini+1:N),yh1(:,Tini+1:N));
   PerformKF(i,:) = PKF;

   %Performance of Delayed Kalman Filter
   PDKF = PerformanceAnalysis(y1(:,Tini+1:N),yhd1(:,Tini+1:N));
   PerformDKF(i,:) = PDKF;
   
   %Performance of Online Filter (in terms of regret)
   PTemp = PerformanceAnalysis(y1(:,Tini+1:N),yReg(:,Tini+1:N));
   PerformReg{1,l}(i,:) = PTemp - PKF;

   PTemp = PerformanceAnalysis(y1(:,Tini+1:N),yRegDelay(:,Tini+1:N));
   PerformRegDelay{1,l}(i,:) = PTemp - PDKF;

   PerformRegCross{1,l}(i,:) = PTemp - PKF;

   end


%take average over different times
 % PerformanceKF = 1/times*sum(PerformKF);
 PerformanceReg(l,:) = 1/times*sum(PerformReg{1,l});

 PerformanceRegDelay(l,:) = 1/times*sum(PerformRegDelay{1,l});

 PerformanceRegCross(l,:) = 1/times*sum(PerformRegCross{1,l});

end

tspan = toc;
% 
% figure(1)
% 
% hold on
% 
% tag = 1:1:H;
% 
% plot(tag,PerformanceReg(:,N-Tini))
% plot(tag,PerformanceReg(:,N-Tini))
% % plot(beta,PerformanceFog1(:,N-Tini))
% % plot(beta,PerformanceFog2(:,N-Tini))

figure(2)

hold on

tag = 1:1:N-Tini;
plot(tag,PerformanceReg(1,:))
plot(tag,PerformanceRegDelay(1,:))
plot(tag,PerformanceRegCross(1,:))

% figure(3)
% hold on
% plot(tag,PerformanceReg(1,:))
% plot(tag,PerformanceReg(2,:))
% % figure(1)
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