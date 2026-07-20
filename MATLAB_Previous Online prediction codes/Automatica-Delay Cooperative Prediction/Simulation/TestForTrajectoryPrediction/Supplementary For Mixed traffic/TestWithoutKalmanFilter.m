times = 50;
m = 1;
tic

%initial of regression parameter
lambda = 1;
beta = 1;

numBeta = length(beta);

Tini = 20;
% Epoh = 7;
N = Tini * (power(2,Epoh));
p = ceil(beta * log(N/2));
gamma = 0.6;
numberVehicle = 1992;

PlotTraj = cell(2,times);
% PerformKF = zeros(times,N-Tini);
PerformReg = cell(1,numBeta);
PerformForget1 = cell(1,numBeta);
PerformForget2 = cell(1,numBeta);
PerformForget3 = cell(1,numBeta);

%collect the regret of different forgetting factor

for i = 1:numBeta
    PerformReg{1,i} = zeros(times,N-Tini);
    PerformForget1{1,i} = zeros(times,N-Tini);
    PerformForget2{1,i} = zeros(times,N-Tini);
    PerformForget3{1,i} = zeros(times,N-Tini);
end

% PerformanceKF = zeros(1,N-Tini);


% Gcollect = cell(1,times);
scale = 1;

minN = 0;
for l = 1:numBeta

   % CollectReg = zeros(times,N-Tini);
   % CollectForget1 = zeros(times,N-Tini);
   % CollectForget2 = zeros(times,N-Tini);
   
   for i = 1:times
   i

   y = scale * Trajectory{1,1848};
   % y1 = scale * Trajectory{1,randi([1,numberVehicle],1,1)};

   len = length(y(1,:));

   Epoch = floor(log(len/Tini)/log(2));

   N = len;

   y10 = y(:,1:N);
   
   noiseG = 0.5 * [randn(1,N);randn(1,N)];
   y1 = y10 + noiseG;
   noiseG = 0.5 * [randn(1,N);randn(1,N)];
   y2 = y10 + noiseG;


   [yReg,G1] = RegressionFilterWithForgettingModified(y1,beta(l),lambda,Tini,Epoch,N,1);
   [yRegD1] = RegressionFilterWithDelay(y1,y2,beta(l),lambda,Tini,Epoch,N,1,1,1);
   [yRegD2] = RegressionFilterWithDelay(y1,y2,beta(l),lambda,Tini,Epoch,N,1,1,2);
   [yRegD3] = RegressionFilterWithDelay(y1,y2,beta(l),lambda,Tini,Epoch,N,1,1,4);
   

   %Performance of Kalman Filter
   % PKF = PerformanceAnalysis(y1(:,Tini+1:N),yh1(:,Tini+1:N));
   % PerformKF(i,:) = PKF;
   
   %Performance of Online Filter (in terms of regret)
   PTemp = PerformanceAnalysis(y1(:,Tini+1:N),yReg(:,Tini+1:N));
   PerformReg{1,l}(i,1:N-Tini) = PTemp;

   PTemp = PerformanceAnalysis(y1(:,Tini+1:N),yRegD1(:,Tini+1:N));
   PerformForget1{1,l}(i,1:N-Tini) = PTemp;

   PTemp = PerformanceAnalysis(y1(:,Tini+1:N),yRegD2(:,Tini+1:N));
   PerformForget2{1,l}(i,1:N-Tini) = PTemp;

   PTemp = PerformanceAnalysis(y1(:,Tini+1:N),yRegD3(:,Tini+1:N));
   PerformForget3{1,l}(i,1:N-Tini) = PTemp;

   % PTemp = PerformanceAnalysis(y1(:,Tini+1:N),yFog2(:,Tini+1:N));
   % PerformForget2{1,l}(i,1:N-Tini) = PTemp;
   
   % Gcollect{1,i} = G1; 
   end


%take average over different times
 % PerformanceKF = 1/times*sum(PerformKF);

 PerformanceReg = zeros(numBeta,N-Tini);
PerformanceFog1 = zeros(numBeta,N-Tini);
PerformanceFog2 = zeros(numBeta,N-Tini);
PerformanceFog3 = zeros(numBeta,N-Tini);
 PerformanceReg(l,:) = 1/times * sum(PerformReg{1,l});
 PerformanceFog1(l,:) = 1/times * sum(PerformForget1{1,l});
 PerformanceFog2(l,:) = 1/times * sum(PerformForget2{1,l});
 PerformanceFog3(l,:) = 1/times * sum(PerformForget3{1,l});
 % PerformanceFog2(l,:) = PerformForget2{1,l};

 % PerformanceReg(l,:) = 1/times*sum(PerformReg{1,l});
 % PerformanceFog1(l,:) = 1/times*sum(PerformForget1{1,l});
 % PerformanceFog2(l,:) = 1/times*sum(PerformForget2{1,l});

 % PerformanceReg(l,:) = 1/times*sum(PerformReg{1,l});
 % PerformanceFog1(l,:) = 1/times*sum(PerformForget1{1,l});
 % PerformanceFog2(l,:) = 1/times*sum(PerformForget2{1,l});

 tspan = toc;


end


% figure(3)
% 
% tag = 1:1:N-Tini;
% hold on
% plot(tag,PerformanceReg(1:N-Tini))
% plot(tag,PerformanceFog1(1:N-Tini))
% % plot(tag,PerformanceFog2(1:N-Tini))

figure(4)

tag = 1:1:N-Tini;
hold on
plot(tag,-PerformanceReg(1:N-Tini)+PerformanceFog1(1:N-Tini))
plot(tag,-PerformanceReg(1:N-Tini)+PerformanceFog2(1:N-Tini))
plot(tag,-PerformanceReg(1:N-Tini)+PerformanceFog3(1:N-Tini))
% plot(tag,PerformanceReg(1:N-Tini)-PerformanceFog2(1:N-Tini))

% figure(5)
% 
% hold on
% plot(y(1,:),y(2,:))
% % plot(y1(1,:),y1(2,:))
% plot(yReg(1,:),yReg(2,:))
% plot(yRegD1(1,:),yRegD1(2,:))
