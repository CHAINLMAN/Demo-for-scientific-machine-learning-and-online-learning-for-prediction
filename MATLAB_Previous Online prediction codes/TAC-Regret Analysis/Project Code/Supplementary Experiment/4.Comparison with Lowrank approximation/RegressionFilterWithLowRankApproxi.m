function [yh,G,outTag,precord] = RegressionFilterWithLowRankApproxi(y,beta,lambda,Tini,Epoh,Weight)
    N = Tini * (power(2,Epoh));
    precord = zeros(N,1);
    [mn,ly] = size(y);
    yh = zeros(mn,N);
    yhh = zeros(mn,N);
    yaug = zeros(mn*ly,1);
    tol = 1e-30;
    
    for i = 1:ly
        yaug((i-1)*mn+1:i*mn,1) = y(:,ly-i+1);
    end

    [kk,~] = size(Weight);
    fReg = zeros(mn*kk,N);
    for i = 1:N
        fReg(:,i) = kron(Weight(:,1:i),eye(mn)) * yaug(mn*(N-i)+1:mn*N,1);
    end

    
    for i = 1:Epoh
        T = power(2,i-1)*Tini+1;
        betaa = beta + 0.5*(i-1);
        p = beta * log(T);
        p = ceil(p);
        Tag = lambda * eye(mn*p);
        Ee = zeros(mn,mn*p);
        G = zeros(mn,mn*p);
        for j = p+1:T
            zz = fReg(1:mn*p,j-1);
            Tag = Tag + zz*zz';
            Ee = Ee + y(:,j)*zz';
            yhh(:,j) = G * zz; %double h means this prediction is not used
            G = G + (y(:,j)-yhh(:,j)) * zz' * pinv(Tag,tol);
        end
        

        for k = T:2*T-2
            precord(k) = p;
            zz = fReg(1:mn*p,k-1);
            yh(:,k) = G * zz;
            Tag = Tag + zz*zz';
            % Ee = Ee + y(:,k)*zz';
            % G = Ee * pinv(Tag);

            G = G + (y(:,k)-yh(:,k)) * zz' * pinv(Tag);
        end
    end
    outTag = Tag;
end