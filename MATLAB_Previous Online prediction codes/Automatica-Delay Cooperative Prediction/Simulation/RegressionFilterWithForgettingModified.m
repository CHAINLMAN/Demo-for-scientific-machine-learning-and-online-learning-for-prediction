function [yh,G,outTag,Tagrecord] = RegressionFilterWithForgettingModified(y,beta,lambda,Tini,Epoh,gamma,H)
    
    N = Tini * (power(2,Epoh))+H-1;
    tol = 1e-20;
    Tagrecord = cell(1,N);
    [mn,~] = size(y);
    yh = zeros(mn,N);
    yhh = zeros(mn,N);
    outTag = zeros(2,N);
    for i = 1:Epoh
        T = power(2,i-1)*Tini+1;
        p = beta * log(T);
        p = ceil(p);
        Tag = lambda * eye(mn*p);
        % Ee = zeros(mn,mn*p);
        G = zeros(mn,mn*p);
        
        %initialization
        
        for j = p+1:T-H+1
            zz = zeros(mn*p,1);
            for l = 1:p
                zz((l-1)*mn+1:l*mn,1) = gamma^(l-1) * y(:,j-l);
            end
            Tag = Tag + zz*zz';
            % Ee = Ee + y(:,j+H-1)*zz';
            yhh(:,j+H-1) = G * zz; %double h means this prediction is not used
            G = G + (y(:,j+H-1)-yhh(:,j+H-1)) * zz' * pinv(Tag,tol);
        end
        % G = Ee * pinv(Tag);
        
        for k = T:2*T-2
            % ee = eig(Tag);
            % outTag(1,k) = min(ee);
            % outTag(2,k) = max(ee);
            % Tagrecord{1,k} = Tag;
            zz = zeros(mn*p,1);
            for l = 1:p
                zz((l-1)*mn+1:l*mn,1) = gamma^(l-1) * y(:,k-l-H+1);
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