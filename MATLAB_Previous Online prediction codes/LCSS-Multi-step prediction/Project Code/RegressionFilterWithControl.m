function [yh,G] = RegressionFilterWithControl(y,u,beta,lambda,Tini,Epoh)
    N = Tini * (power(2,Epoh));
    yh = zeros(N,1);
    for i = 1:Epoh
        T = power(2,i-1)*Tini+1;
        p = beta * log(T);
        p = ceil(p);
        Tag = lambda * eye(2*p);
        Ee = zeros(1,2*p);
        for j = p:T
            zz = [y(j-p+1:j,1);u(j-p+1:j,1)];
            Tag = Tag + zz*zz';
            Ee = Ee + y(j)*zz';
        end
        G = Ee * pinv(Tag);
        for k = T:2*T-2
            info = [y(k-p:k-1,1);u(k-p:k-1,1)];
            yh(k) = G * info;
            Tag = Tag + info*info';
            G = G + (y(k)-yh(k)) * info' * pinv(Tag);
        end
    end
end