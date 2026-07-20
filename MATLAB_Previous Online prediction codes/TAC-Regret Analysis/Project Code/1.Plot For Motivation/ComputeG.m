function [G,P] = ComputeG(A,C,Q,R,p)
    [m,~] = size(A);
    P0 = eye(m);
    times = 1000;
    [m,~] = size(C);
    G = zeros(m,m*p);
    for i = 1:times
       P0 = A*P0*A'+Q-A*P0*C'*pinv(R+C*P0*C')*C*P0*A';
    end
    L = A * P0 * C' * pinv(C * P0 * C' + R);
    G(:,1:m) = C*L;
    Atil = A-L*C;
    for i = 1:p-1
        G(:,m*i+1:m*(i+1)) = C*Atil*L;
        Atil = Atil * (A-L*C);
    end
    P = C*P0*C'+R;
end