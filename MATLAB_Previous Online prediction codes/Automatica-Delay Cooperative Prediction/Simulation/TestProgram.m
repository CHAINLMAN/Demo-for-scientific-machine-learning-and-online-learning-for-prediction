times = 1;
A = [0.99,0.1;0,0.9];
C = [1,0];
B = [0,0.5;1,0];

Q = 0.1*eye(2);
R = 1;
Qy = 1;
Qf = 1;
Ru = eye(2);


lambda = 1;
beta = 2;
W = 15;
Epoh = 3;
Tini = 100;
N = Tini * (power(2,Epoh));


% x0 = rand(2,1);
% [my,~] = size(R);
% y0 = C * x0 + mvnrnd(zeros(my,1),R)';


[xstate,y,u,yh,G,Z] = ...
    RegressionFilterWithMPC(x0,y0,beta,lambda,Tini,Epoh,W,A,B,C,Q,R,Qy,Ru,Qf);

tag = 1:1:N;
plot(tag,xstate)
% plot(tag,log(abs(xstate)))


% Ubar = 1;
% 
% PerformH = zeros(N-Tini,times);
% PerformTil = zeros(N-Tini,times);
% 
% for i = 1:times
% 
%    [y,u,x] = ProcessWithU(A,B,C,Q,R,x0,Ubar,N);
%    yh = KalmanFilterWithU(A,B,C,Q,R,y,x0,u);
%    % [ytil,G] = RegressionFilterUnstable(y,beta,lambda,Tini,Epoh);
%    [ytil,G] = RegressionFilterWithControl(y,u,beta,lambda,Tini,Epoh);
% 
%    PerformH(1,i) = (y(Tini+1)-yh(Tini+1))^2;
%    PerformTil(1,i) = (y(Tini+1)-ytil(Tini+1))^2;
%    for j = 2: N - Tini
%     PerformH(j,i) = PerformH(j-1,i) + (y(j+Tini)-yh(j+Tini))^2;
%     PerformTil(j,i) = PerformTil(j-1,i) + (y(j+Tini)-ytil(j+Tini))^2;   
%    end
% end



% PerformanceYh = sum(PerformH,2);
% PerformanceYtil = sum(PerformTil,2);
% 
% tag = 1:1:N-Tini;
% figure(1)
% for i = 1:6
% subplot(2,3,i)
% hold on
% plot(log(tag).^i,PerformanceYtil-PerformanceYh)
% end