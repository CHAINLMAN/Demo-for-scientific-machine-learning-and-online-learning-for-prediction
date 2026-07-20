% A = [0.2,0.8;0.4,0.6];
% 

A = [1,0.3;0,1];

C1 = [1,0];

C2 = [0,1];

Q = 1*eye(2);

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

step = 20;

P = dare(A',C',Q,R);
P0 = P;

Ps = dare(A',C1',Q,R1);

trP = zeros(1,step);

trP(1) = trace(P);

for i = 1:step-1

    P = RicRecursion(A,C1,Q,R1,P);

    trP(i+1) = trace(P);

end




LW = 2.5;
LWlabel = 2;
fZ = 30;
fZlegend = 25;
fZlabel = 30;
region = 2:21;

tag = 1:1:step;
hold on
plot(tag,trace(P0)*ones(1,step),'LineWidth',LW)
plot(tag,trP,'LineWidth',LW)
plot(tag,trace(Ps)*ones(1,step),'LineWidth',LW)
legend('Global','Delay','Local','Interpreter','latex','FontSize',fZlegend)

% PoltForMotivation
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