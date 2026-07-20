function [yh,G,outTag,Tagrecord] = RegressionFilterWithControlModified(y,u,beta,lambda,Tini,Epoh,gamma,H)
    
    N = Tini * (power(2,Epoh))+H-1;
    tol = 1e-20;
    Tagrecord = cell(1,N);
    [mn,~] = size(y);
    [mb,~] = size(u);
    yh = zeros(mn,N);
    yhh = zeros(mn,N);
    outTag = zeros(2,N);
    for i = 1:Epoh

        T = power(2,i-1)*Tini+1;
        p = beta * log(T);
        p = ceil(p);
        Tag = lambda * eye(mn*p+mb*(p+H));
        % Ee = zeros(mn,mn*p);
        G = zeros(mn,mn*p+mb*(p+H));
        
        %initialization
        
        for j = p+H+1:T-1
            zzy = zeros(mn*p,1);
            zzu = zeros(mb*(p+H),1);
            for l = 1:p
                zzy((l-1)*mn+1:l*mn,1) = gamma^(l-1) * y(:,j-H-l);
            end
            for l = 1:p+H
                zzu((l-1)*mb+1:l*mb,1) = gamma^(l-1) * u(:,j-l);
            end
            zz = [zzy;zzu];
            Tag = Tag + zz*zz';
            % Ee = Ee + y(:,j+H-1)*zz';
            yhh(:,j) = G * zz; %double h means this prediction is not used
            if i == 1
                yh(:,j) = yhh(:,j);
            end
            G = G + (y(:,j)-yhh(:,j)) * zz' * pinv(Tag,tol);
        end

        if i == 1
            for j = T:T+H-1
                zzy = zeros(mn*p,1);
                zzu = zeros(mb*(p+H),1);
                for l = 1:p
                     zzy((l-1)*mn+1:l*mn,1) = gamma^(l-1) * y(:,j-H-l);
                end
                for l = 1:p+H
                    zzu((l-1)*mb+1:l*mb,1) = gamma^(l-1) * u(:,j-l);
                end
                zz = [zzy;zzu];
                yh(:,j) = G * zz;
            end
        end
        % G = Ee * pinv(Tag);
        
        for k = T:2*T-2
            % ee = eig(Tag);
            % outTag(1,k) = min(ee);
            % outTag(2,k) = max(ee);
            % Tagrecord{1,k} = Tag;
            zzy = zeros(mn*p,1);
            zzu = zeros(mb*(p+H),1);
            for l = 1:p
                zzy((l-1)*mn+1:l*mn,1) = gamma^(l-1) * y(:,k-l);
            end

            for l = 1:p+H
                zzu((l-1)*mb+1:l*mb,1) = gamma^(l-1) * u(:,k+H-l);
            end

            zz = [zzy;zzu];

            yh(:,k+H) = G * zz;

            for l = 1:p
                zzy((l-1)*mn+1:l*mn,1) = gamma^(l-1) * y(:,k-l-H);
            end

            for l = 1:p+H
                zzu((l-1)*mb+1:l*mb,1) = gamma^(l-1) * u(:,k-l);
            end

            zz = [zzy;zzu];

            Tag = Tag + zz*zz';

            % Ee = Ee + y(:,k)*zz';
            % G = Ee * pinv(Tag);

            G = G + (y(:,k)-yh(:,k)) * zz' * pinv(Tag);
        end
    end
    % outTag = Tag;
end