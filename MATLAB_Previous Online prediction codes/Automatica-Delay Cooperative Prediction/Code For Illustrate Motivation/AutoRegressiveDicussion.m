A = 1;
C = 1;
Q = 1;

R = 1:1:1000;

len = length(R);

fedA = zeros(1,len);

for i = 1:len

    P = dare(A',C',Q,R(i));

    L = A*P*C'*pinv(C*P*C'+R(i));

    fedA(i) = max(abs(eig(A-L*C)));

end