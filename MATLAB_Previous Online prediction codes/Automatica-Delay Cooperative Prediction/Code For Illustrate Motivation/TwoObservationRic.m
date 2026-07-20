% A = [0.2,0.8;0.4,0.6];
% 

A = [0.8,0;0,0.8];

C1 = [1,0];

C2 = [0,1];

Q = eye(2);

R1 = 1;

R2 = 1;

C = [C1;C2];

R = blkdiag(R1,R2);

% A = [0.5,0.5,0;0,0.1,0.9;0,0.1,0.9];
% 
% C1 = [1,0,0];
% 
% C2 = [0,0,1];
% 
% Q = 10*eye(3);
% 
% R1 = 1;
% 
% R2 = 1;

U = rand(2);
U = orth(U);
P0 = 10 * U*diag(rand(2,1))*U';

P1 = P0;
P2 = P0;
steps = 6;

errorLoc = zeros(1,steps);
errorGlo = zeros(1,steps);

for i = 1:steps

    errorLoc(i) = C1*P1*C1' + R1;
    errorGlo(i) = C1*P2*C1' + R1;

    P1 = RicRecursion(A,C1,Q,R1,P1);
    P2 = RicRecursion(A,C,Q,R,P2);

end


tag = 1:1:steps;
PoltForMotivation
% P1 = dare(A',C1',Q,R1);
% 
% Ptogether = dare(A',[C1',C2'],Q,blkdiag(R1,R2));
% 
% %comparison of different 
% C1 * P1 * C1' + R1
% 
% C1 * Ptogether * C1' + R1




function P = RicRecursion(A,C,Q,R,P0)


    P = A*P0*A'+Q-A*P0*C'*pinv(C*P0*C'+R)*C*P0*A';

end