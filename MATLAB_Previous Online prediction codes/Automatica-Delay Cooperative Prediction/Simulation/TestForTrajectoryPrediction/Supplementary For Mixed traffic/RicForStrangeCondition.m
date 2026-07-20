A = 5 * rand(3);
% Q = [1,0,0;0,1,0;0,0,0];
Q = zeros(3);
R = 0.1*eye(3);
C = eye(3);

P1 = dare(A',C,Q,R);
K = -A*P1*C'*pinv(C*P1*C'+R);
eig(A+K*C)
% times = 2000;
% feedback = zeros(1,times);
% 
% Afed = eye(3);
% 
% for i = 1:times
% 
%     K = -pinv(B'*P0*B+R)*B'*P0*A;
% 
%     Afed = (A+B*K) * Afed;
% 
%     feedback(i) = sqrt(max((eig(Afed*Afed'))));
% 
%     P0 = A'*P0*A + Q - A'*P0*B*pinv(B'*P0*B+R)*B'*P0*A;
% 
% end
% 
% P = dare(A,B,Q,R)
% K = -pinv(B'*P*B+R)*B'*P*A