function [xstate,y,u,yh,G,Z] = RegressionFilterWithMPC(x0,y0,beta,lambda,Tini,Epoh,W,A,B,C,Q,R,Qy,Ru,Qf)
    N = Tini * (power(2,Epoh));
    
    [n,~] = size(Q); 

    [m,~] = size(R);

    [~,nu] = size(B);

    xstate = zeros(n,N);
    
    xstate(:,1) = x0;

    y = zeros(m,N);

    yh = zeros(m*W,N);

    y(:,1) = y0;

    u = zeros(nu,N);

    p = ceil(beta * log(N));

    paug = p + W;

    dimZ = m*p+nu*(paug-1);

    Z = zeros(dimZ,N-p+1);
    
    %initialization phase
    scale = 1;
    u(:,1:Tini) = scale * rand(nu,Tini);
    
    for i = 2:Tini

        [xp,yp] = propagation(xstate(:,i-1),u(:,i-1),A,B,C,Q,R);

        xstate(:,i) = xp;
        
        y(:,i) = yp;

    end
    
    %initialize the data set Z
    for i = 1:Tini-p+1
        zz = zeros(dimZ,1);
        
        for j = 1:p
            zz(m*(j-1)+1:m*j) = y(:,i+j-1);
        end

        for j = 1:paug-1
            zz(m*p+(j-1)*nu+1:m*p+j*nu) = u(:,i+j-1);
        end

        Z(:,i) = zz;
    end

    G = zeros(W*m,m*p+nu*(paug-1));
    Tag = cell(1,W);
    Cross = cell(1,W);


    %initialize the original G
    for l = 1:W
        
        Tag{1,l} = lambda * eye(m*p+nu*(p+l-1));
        Cross{1,l} = zeros(m,m*p+nu*(p+l-1));
        
        for i = p+l:Tini
            
            TruncZ = Z(1:m*p+nu*(p+l-1),i-(p+l-1));
            Tag{1,l} = Tag{1,l} + TruncZ * TruncZ';
            Cross{1,l} = Cross{1,l} + y(:,i)*TruncZ';

        end
    
        G(m*(l-1)+1:m*l,1:m*p+nu*(p+l-1)) = Cross{1,l} * pinv(Tag{1,l});
    end

    BigQy = kron(eye(W-1),Qy);
    BigQy = blkdiag(BigQy,Qf);
    BigRu = kron(eye(W-1),Ru);


    for i = Tini+1:N
        %Propagation with the control input at the previous time step
        [xp,yp] = propagation(xstate(:,i-1),u(:,i-1),A,B,C,Q,R);

        xstate(:,i) = xp;
        
        y(:,i) = yp;


        %We make prediction and correction first

        for l = 1:W
            TruncZ = Z(1:m*p+nu*(p+l-1),i-(p+l-1));
            Gtemp = G(m*(l-1)+1:m*l,1:m*p+nu*(p+l-1));
            yh(m*(l-1)+1:m*l,i) =  Gtemp * TruncZ;
            Tag{1,l} = Tag{1,l} + TruncZ*TruncZ';
            Gtemp = Gtemp + (y(i)-yh(m*(l-1)+1:m*l,i)) ...
                    * TruncZ' * pinv(Tag{1,l});
            G(m*(l-1)+1:m*l,1:m*p+nu*(p+l-1)) = Gtemp;
        end
        
        %then we design the control input with MPC

        TilGQ = G'*BigQy*G;
        % Til11 = TilGQ(1:(m+nu)*p,1:(m+nu)*p);
        Til21 = TilGQ((m+nu)*p+1:dimZ,1:(m+nu)*p);
        Til22 = TilGQ((m+nu)*p+1:dimZ,(m+nu)*p+1:dimZ);
        bigU = pinv(BigRu+Til22) * Til21 * Z(1:(m+nu)*p,i-1);
        u(:,i) = -bigU(1:nu); 


        %update Z(i)
       
        
        
        
        for j = 1:p
               
            Z(m*(j-1)+1:m*j,i) = y(:,i+j-p);

            Z(m*p+(j-1)*nu+1:m*p+j*nu,i) = u(:,i+j-p);
        end

       

        for j = 1:W-1
            
            indexu = (m+nu)*p+(j-1)*nu + 1;
            Z(indexu:indexu+nu-1,i-j) = u(:,i);
        end

    end



end





% Tag = lambda * eye(2*p);
        % Ee = zeros(1,2*p);
        % for j = p:T
        %     zz = [y(j-p+1:j,1);u(j-p+1:j,1)];
        %     Tag = Tag + zz*zz';
        %     Ee = Ee + y(j)*zz';
        % end
        % G = Ee * pinv(Tag);
        % for k = T:2*T-2
        %     info = [y(k-p:k-1,1);u(k-p:k-1,1)];
        %     yh(k) = G * info;
        %     Tag = Tag + info*info';
        %     G = G + (y(k)-yh(k)) * info' * pinv(Tag);
        % end