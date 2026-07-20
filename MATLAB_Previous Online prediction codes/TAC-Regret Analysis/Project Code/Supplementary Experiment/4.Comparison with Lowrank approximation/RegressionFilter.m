function [yh,G,G1,G2,outTag,precord] = RegressionFilter(y,beta,lambda,Tini,Epoh)
    N = Tini * (power(2,Epoh));
    precord = zeros(N,1);
    [mn,~] = size(y);
    yh = zeros(mn,N);
    yhh = zeros(mn,N);
    outTag = zeros(mn,N);
    tol = 1e-30;
    for i = 1:Epoh
        T = power(2,i-1)*Tini+1;
        p = beta * log(T);
        p = ceil(p);
        Tag = lambda * eye(mn*p);
        Ee = zeros(mn,mn*p);
        G = zeros(mn,mn*p);
        for j = p+1:T
            zz = zeros(mn*p,1);
            for l = 1:p
                zz((l-1)*mn+1:l*mn,1) = y(:,j-l);
            end
            Tag = Tag + zz*zz';
            Ee = Ee + y(:,j)*zz';
            yhh(:,j) = G * zz; %double h means this prediction is not used
            G = G + (y(:,j)-yhh(:,j)) * zz' * pinv(Tag,tol);
        end
        G = Ee * pinv(Tag);
        G1 = G;
        G2 = G;
        for k = T:2*T-2
            precord(k) = p;
            zz = zeros(mn*p,1);
            for l = 1:p
                zz((l-1)*mn+1:l*mn,1) = y(:,k-l);
            end
            yh(:,k) = G * zz;
            Tag = Tag + zz*zz';
            Ee = Ee + y(:,k)*zz';
            G = Ee * pinv(Tag);
            gg = G;
            % G = G + (y(:,k)-yh(:,k)) * zz' * pinv(Tag);
            G2 = G2 * (Tag - zz*zz')*pinv(Tag) + y(:,k) * zz' * pinv(Tag);
        end
    end
    outTag = Tag;
end