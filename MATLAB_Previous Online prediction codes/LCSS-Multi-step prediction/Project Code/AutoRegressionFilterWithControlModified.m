function [yh,G,outTag,Tagrecord] = AutoRegressionFilterWithControlModified(y,u,beta,lambda,Tini,Epoh,gamma,H)
    
    N = Tini * (power(2,Epoh))+H-1;
    tol = 1e-20;
    Tagrecord = cell(1,N);
    [mn,~] = size(y);
    [mb,~] = size(u);
    yh = zeros(mn,N);
    yhs = zeros(mn,N);
    yhh = zeros(mn,N);
    outTag = zeros(2,N);
    for i = 1:Epoh
        T = power(2,i-1)*Tini+1;
        p = beta * log(T);
        p = ceil(p);
        Tag = lambda * eye((mn+mb)*p);
        % Ee = zeros(mn,mn*p);
        G = zeros(mn,(mn+mb)*p);
        
        %initialization
        
        for j = p+1:T-1
            zzy = zeros(mn*p,1);
            zzu = zeros(mb*p,1);
            for l = 1:p
                zzy((l-1)*mn+1:l*mn,1) = gamma^(l-1) * y(:,j-l);
            end
            for l = 1:p
                zzu((l-1)*mb+1:l*mb,1) = gamma^(l-1) * u(:,j-l);
            end
            zz = [zzy;zzu];
            Tag = Tag + zz*zz';
            % Ee = Ee + y(:,j+H-1)*zz';
            yhh(:,j) = G * zz; %double h means this prediction is not used
            G = G + (y(:,j)-yhh(:,j)) * zz' * pinv(Tag,tol);
        end
        % G = Ee * pinv(Tag);
        
        for k = T:2*T-2
            % ee = eig(Tag);
            % outTag(1,k) = min(ee);
            % outTag(2,k) = max(ee);
            % Tagrecord{1,k} = Tag;
            zzy = zeros(mn*p,1);
            zzu = zeros(mb*p,1);
            for l = 1:p
                zzy((l-1)*mn+1:l*mn,1) = gamma^(l-1) * y(:,k-l);
            end
            for l = 1:p
                zzu((l-1)*mb+1:l*mb,1) = gamma^(l-1) * u(:,k-l);
            end
            zz = [zzy;zzu];

            yhs(:,k) = G * zz;

            Tag = Tag + zz*zz';

            zz0 = zz;

            y0 = G * zz0;
            
            for j = 1:H
              
                zz0 = [y0;zz0(1:(p-1)*mn);u(:,k+j-1);zz0(p*mn+1:p*mn+(p-1)*mb)];

                y0 = G * zz0;
            end

            yh(:,k+H) = y0;
            
            % Ee = Ee + y(:,k)*zz';
            % G = Ee * pinv(Tag);

            G = G + (y(:,k)-yhs(:,k)) * zz' * pinv(Tag);
        end
    end
    % outTag = Tag;
end