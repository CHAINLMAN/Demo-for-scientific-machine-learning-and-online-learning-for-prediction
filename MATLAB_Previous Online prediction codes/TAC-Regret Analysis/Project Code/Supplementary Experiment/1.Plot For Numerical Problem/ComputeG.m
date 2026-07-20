function [G,P] = ComputeG(A,C,Q,R,p)
    [m,~] = size(C);
    G = zeros(m,m*p);
    P0 = dare(A',C',Q,R);
    L = A * P0 * C' * pinv(C * P0 * C' + R);
    G(:,1:m) = C*L;
    Atil = A-L*C;
    for i = 1:p-1
        G(:,m*i+1:m*(i+1)) = C*Atil*L;
        Atil = Atil * (A-L*C);
    end
    P = C*P0*C'+R;
end