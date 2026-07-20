function [yh,G,outTag,Tagrecord] = RegressionFilterWithForgetting(y,beta,lambda,Tini,Epoh,gamma)
    N = Tini * (power(2,Epoh));
    Tagrecord = cell(1,N);
    [mn,~] = size(y);
    yh = zeros(mn,N);
    outTag = zeros(2,N);
    for i = 1:Epoh
        T = power(2,i-1)*Tini+1;
        p = beta * log(T);
        p = ceil(p);
        Tag = lambda * eye(mn*p);
        Ee = zeros(mn,mn*p);
        for j = p+1:T
            zz = zeros(mn*p,1);
            for l = 1:p
                zz((l-1)*mn+1:l*mn,1) = gamma^(l-1) * y(:,j-l);
            end
            Tag = Tag + zz*zz';
            Ee = Ee + y(:,j)*zz';
        end
        G = Ee * pinv(Tag);
        
        for k = T:2*T-2
            ee = eig(Tag);
            outTag(1,k) = min(ee);
            outTag(2,k) = max(ee);
            Tagrecord{1,k} = Tag;
            zz = zeros(mn*p,1);
            for l = 1:p
                zz((l-1)*mn+1:l*mn,1) = gamma^(l-1) * y(:,k-l);
            end
            yh(:,k) = G * zz;
            Tag = Tag + zz*zz';
            % Ee = Ee + y(:,k)*zz';
            % G = Ee * pinv(Tag);

            G = G + (y(:,k)-yh(:,k)) * zz' * pinv(Tag);
        end
    end
    % outTag = Tag;
end