times = 10;
m = 3;
tic
%initial of system parameter
% % A = [0.2,0.7,0;0.1,0.3,0.3;0.7,0,0.7];
% A = [0.98,0.8,0;0,0.98,0.8;0,0,0.9];
% C2 = eye(m);
% Q = eye(dimA);
% gg = 100;
% R2 = gg*eye(m);
% [dimA,~] = size(A);

% A = 1;
% [dimA,~] = size(A);
% 
% 
% C2 = 0.001;
% Q = 0.001;
% R2 = 0.001;



%initial of regression parameter
lambda = 1;
beta = 6;
Epoh = 3;
Tini = 500;
N = Tini * (power(2,Epoh));
gamma = 0.6;


% H = HankelMatrix(N);
% [Vec,Eigen] = eig(H);
Para = Vec(:,N-ceil(beta*log(N))+1:N);
Para = flip(Para');

PerformH = zeros(N-Tini,times);
PerformTil = zeros(N-Tini,times);
PerformLow = zeros(N-Tini,times);
PerformForget = zeros(N-Tini,times);


for i = 1:times
   x0 = rand(dimA,1);
   
   [xstate] = Process(A,Q,x0,N);
   
   [y2] = observationProcess(xstate,C2,R2);

   
   [yh2,sigma2] = KalmanFilter(A,C2,Q,R2,y2,x0);

   [ytil] = RegressionFilter(y2,beta,lambda,Tini,Epoh);
   [ylowR,G3,Tag3] = RegressionFilterWithLowRankApproxi(y2,beta,lambda,Tini,Epoh,Para);
   [yForg,G4,Tag4] = RegressionFilterWithForgettingModified(y2,beta,lambda,Tini,Epoh,gamma);

   PerformH(1,i) = norm(y2(:,Tini+1)-yh2(:,Tini+1))^2;
   PerformTil(1,i) = norm(y2(:,Tini+1)-ytil(:,Tini+1))^2;

   PerformLow(1,i) = norm(y2(:,Tini+1)-ylowR(:,Tini+1))^2;

   PerformForget(1,i) = norm(y2(:,Tini+1)-yForg(:,Tini+1))^2;

   for j = 2: N - Tini

    PerformH(j,i) = PerformH(j-1,i) + norm(y2(:,j+Tini)-yh2(:,j+Tini))^2;
    PerformTil(j,i) = PerformTil(j-1,i) + norm(y2(:,j+Tini)-ytil(:,j+Tini))^2;

    PerformLow(j,i) = PerformLow(j-1,i) + norm(y2(:,j+Tini)-ylowR(:,j+Tini))^2;
    PerformForget(j,i) = PerformForget(j-1,i) + norm(y2(:,j+Tini)-yForg(:,j+Tini))^2;
   
   end
end


PerformanceH = 1/times*sum(PerformH,2);
PerformanceTil = 1/times*sum(PerformTil,2);
PerformanceLow = 1/times*sum(PerformLow,2);
PerformanceFor = 1/times*sum(PerformForget,2);


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
%   plot(log(tag).^i,PerformanceYtil1-PerformanceFor)
%   xlabel(append('log(N)^',num2str(i)))
%   ylabel('Regret')
% end

% figure(3)
% plot(tag,PerformanceYtil1)
% hold on
% plot(tag,PerformanceTil)
% plot(tag,PerformanceLow)
% plot(tag,PerformanceFor)
% xlabel('time step')
% ylabel('Performance')

figure(4)
subplot(1,2,1)
hold on
plot(tag,PerformanceTil-PerformanceH,'LineWidth',2)
plot(tag,PerformanceLow-PerformanceH,'LineWidth',2)
plot(tag,PerformanceFor-PerformanceH,'LineWidth',2)

xlabel('time step')
ylabel('Performance Difference')

subplot(1,2,2)
plot(tag,PerformanceTil-PerformanceLow,'LineWidth',2)


% G1hat = ComputeG(A,C1,Q,R1,ceil(beta*log(N/2)));
% norm(G1-G1hat)
% G2hat = ComputeG(A,C2,Q,R2,ceil(beta*log(N/2)));
% norm(G2-G2hat)
% 
% max(eig(Tag1))
% max(eig(Tag2))
% max(eig(Tag3))
tspan = toc;