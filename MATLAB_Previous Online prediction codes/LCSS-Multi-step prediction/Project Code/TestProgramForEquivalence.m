times = 20;
m = 1;
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
% Ablk = [1,1;0,1];
% A = kron(eye(m),Ablk);
% B1 = [0;1];
% B = kron(eye(m),B1);
% C1 = [1,0];
% C = kron(eye(m),C1);

Ablk = [1,0.5,0;0,1,0.5;0,0,0.9];
A = kron(eye(m),Ablk);
B1 = [0;0;1];
B = kron(eye(m),B1);
C1 = [1,0,0];
C = kron(eye(m),C1);


[dimA,~] = size(A);
% W = rand(dimA);
% W = orth(W);
% D1 = diag(rand(1,dimA));
% Mid = D1;
Q = 0.01*eye(dimA);
R = 0.01*eye(m);

%initial of regression parameter
lambda = 1;
beta = 2;
% gamma = 0.3:0.05:1;
% numGamma = length(gamma);
Epoh = 3;
Tini = 400;
N = Tini * (power(2,Epoh));
p = ceil(beta * log(N/2));

H = 18;

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
x0 = rand(dimA,1);
   % x0 = zeros(dimA,1);
   U = randn(m,N+H);
   [y,xstate] = ProcessWithPrescribedU(A,B,C,Q,R,x0,U,N);