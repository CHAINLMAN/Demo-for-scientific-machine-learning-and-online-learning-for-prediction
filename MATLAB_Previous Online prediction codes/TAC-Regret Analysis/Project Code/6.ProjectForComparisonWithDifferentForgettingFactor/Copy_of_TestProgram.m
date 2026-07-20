times = 50;
m = 3;
tic
%initial of system parameter
% A = [0.2,0.7,0;0.1,0.3,0.3;0.7,0,0.7];

A = [1,1,0;0,1,1;0,0,0.9];
C1 = [1,0,0];
C2 = C1;

[dimA,~] = size(A);
Q = eye(dimA);
R1 = 1;
R2 = 1;

% T = 0.2;
% A = [1,T,0;0,1,T;0,0,1];
% Q = diag([T^2,T^2/2,T]);
% R1 = T^2;
% R2 = T^2*eye(m);
% C2 = eye(m);


%initial of regression parameter
lambda = 1;
beta = 4;
Epoh = 7;
Tini = 50;
N = Tini * (power(2,Epoh));
p = ceil(beta * log(N/2));
gamma = 0.6;

%initial of topology parameter
% obtainTopology;
% La = pinv(diag(sum(L,2)))*L;
% fusionStep = 6;
% La = mpower(La,fusionStep);



PerformH1 = zeros(N-Tini,times);
PerformTil1 = zeros(N-Tini,times);
PerformH2 = zeros(N-Tini,times);
PerformTil2 = zeros(N-Tini,times);
PerformTilSum = zeros(N-Tini,times);
PerformTilSub = zeros(N-Tini,times);

Gcollect = cell(1,times);

y = zeros(times,N);
yhat = zeros(times,N);

for i = 1:times
   % x0 = rand(dimA,1);
   x0 = zeros(dimA,1);
   
   [xstate] = Process(A,Q,x0,N);
   [y1] = observationProcess(xstate,C1,R1);
   [y2] = observationProcess(xstate,C2,R2);

   [yh1,sigma1] = KalmanFilter(A,C1,Q,R1,y1,x0);
   [yh2,sigma2] = KalmanFilter(A,C2,Q,R2,y2,x0);

   [ytil1,G1,G11,G12,Tag1,Tag1R] = RegressionFilter(y1,beta,lambda,Tini,Epoh);
   [ytil2,G2,Gout,G22,Tag2,Tag2R] = RegressionFilter(y2,beta,lambda,Tini,Epoh);
   [ytilsum,G3,Tag3,Tag3R] = RegressionFilterWithForgettingModified(y2,beta,lambda,Tini,Epoh,sigma2);
   [ytilsub,G4,Tag4,Tag4R] = RegressionFilterWithForgettingModified(y2,beta,lambda,Tini,Epoh,gamma);

   PerformH1(1,i) = (y1(Tini+1)-yh1(Tini+1))^2;
   PerformTil1(1,i) = (y1(Tini+1)-ytil1(Tini+1))^2;

   PerformH2(1,i) = (y2(1,Tini+1)-yh2(1,Tini+1))^2;
   PerformTil2(1,i) = (y2(1,Tini+1)-ytil2(1,Tini+1))^2;

   PerformTilSum(1,i) = (y2(1,Tini+1)-ytilsum(1,Tini+1))^2;
   PerformTilSub(1,i) = (y2(1,Tini+1)-ytilsub(1,Tini+1))^2;

   for j = 2: N - Tini

    PerformH1(j,i) = PerformH1(j-1,i) + (y1(j+Tini)-yh1(j+Tini))^2;
    PerformTil1(j,i) = PerformTil1(j-1,i) + (y1(j+Tini)-ytil1(j+Tini))^2;

    PerformH2(j,i) = PerformH2(j-1,i) + (y2(1,j+Tini)-yh2(1,j+Tini))^2;
    PerformTil2(j,i) = PerformTil2(j-1,i) + (y2(1,j+Tini)-ytil2(1,j+Tini))^2;

    PerformTilSum(j,i) = PerformTilSum(j-1,i) + (y2(1,j+Tini)-ytilsum(1,j+Tini))^2;
    PerformTilSub(j,i) = PerformTilSub(j-1,i) + (y2(1,j+Tini)-ytilsub(1,j+Tini))^2;

   end

   Gcollect{1,i} = G2; 
end



PerformanceYh1 = 1/times*sum(PerformH1,2);
PerformanceYtil1 = 1/times*sum(PerformTil1,2);
PerformanceYh2 = 1/times*sum(PerformH2,2);
PerformanceYtil2 = 1/times*sum(PerformTil2,2);
PerformanceSum = 1/times*sum(PerformTilSum,2);
PerformanceSub = 1/times*sum(PerformTilSub,2);


% figure(1)
% for i = 1:6
%   subplot(2,3,i)
%   hold on
%   plot(log(tag).^i,PerformanceYtil1-PerformanceYh1)
%   plot(log(tag).^i,PerformanceYtil2-PerformanceYh2)
% plot(log(tag).^i,PerformanceYtil1-PerformanceYtil2)
% end

tag = 1:1:N-Tini;
figure(2)
for i = 1:6
  subplot(2,3,i)
  hold on
  plot(log(tag).^i,PerformanceYtil1-PerformanceYtil2)
  xlabel(append('log(N)^',num2str(i)))
  ylabel('Regret')
end

figure(3)
% plot(tag,PerformanceYtil1,'LineWidth',2)
hold on
plot(tag,PerformanceYh1,'LineWidth',2)
% plot(tag,PerformanceYtil2,'LineWidth',2)
plot(tag,PerformanceYh2,'LineWidth',2)
plot(tag,PerformanceSum,'LineWidth',2)
xlabel('time step')
ylabel('Performance')

figure(4)
tag = 1:1:N-Tini;
subplot(1,2,1)
hold on
% plot(tag,PerformanceYtil2-PerformanceYh2,'LineWidth',2)
plot(tag,PerformanceSum-PerformanceYh2,'LineWidth',2)
plot(tag,PerformanceSub-PerformanceYh2,'LineWidth',2)

xlabel('time step')
ylabel('Performance Difference')

subplot(1,2,2)
plot(tag,PerformanceYtil2-PerformanceSum,'LineWidth',2)


G1hat = ComputeG(A,C1,Q,R1,ceil(beta*log(N/2)));
norm(G1-G1hat)
G2hat = ComputeG(A,C2,Q,R2,ceil(beta*log(N/2)));
norm(G2-G2hat)

% max(eig(Tag1))
% max(eig(Tag2))
% max(eig(Tag3))
sequence = [];
for i = 1:ceil(beta*log(N/2))
     sequence = [sequence,1/(sigma2^(i-1))];
end
G3hat = G2hat * kron(diag(sequence),eye(1));
sequence = [];
for i = 1:ceil(beta*log(N/2))
     sequence = [sequence,1/(gamma^(i-1))];
end
G4hat = G2hat * kron(diag(sequence),eye(1));
norm(G2-G2hat)/norm(G2)
norm(G3-G3hat)/norm(G3)
norm(G4-G4hat)/norm(G4)
norm((G2-G2hat)./G2hat)
norm((G3-G3hat)./G3hat)
norm((G4-G4hat)./G4hat)
tspan = toc;

% biasx = G2hat(1:m,m*(p-1)+1:m*p) * xstate;
% wholebias = trace(biasx*biasx');
% maxvalue = max(max(abs(xstate)));
% 
% 
% p = ceil(beta*log(N/2));
% G2hat(1:3,m*(p-1)+1:m*p) * xstate(:,N)
% 
% 
% figure(10)
% tag = 1:1:6400;
% plot(tag,xstate)