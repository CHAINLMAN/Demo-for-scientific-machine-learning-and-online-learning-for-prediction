times = 100;

N = 5000;

p = 30;

rho = 0.50;

R = 4;

Correlated = 0;
CorreEach = zeros(1,times);
Unrelated = 0;
UnreEach = zeros(1,times);

flagC = 0;
flagU = 0;
Tinit = 50;

tic
for i = 1:times

    MartingaleC = zeros(1,N);
    MartingaleN = zeros(1,N);

    [y,e] = Autoregressive(N,0,R,rho);

    Y = Augment(y,N,p);

    z = 10000 * rand(1,N);

    MidCor = pinv(Y * Y');
    Cross = e(p:N) * Y';
    subCor = Cross * MidCor * Cross';
    CorreEach(i) = subCor;

    Z = Augment(z,N,p);
    MidUn = pinv(Z * Z');
    Cross = e(p:N) * Z';
    subUn = Cross * MidUn * Cross';
    UnreEach(i) = subUn;


    % for j = Tinit:N-p+1
    % 
    %     YTrunc = Y(:,1:j);
    %     eTrunc = e(:,p:j+p-1);
    %     ZTrunc = Z(:,1:j);
    %     Cross = eTrunc * YTrunc';
    %     MartingaleC(j) = Cross * pinv(YTrunc*YTrunc') * Cross';
    %     Cross = eTrunc * ZTrunc';
    %     MartingaleN(j) = Cross * pinv(ZTrunc*ZTrunc') * Cross';
    % 
    % end

    Correlated = Correlated + subCor;
    Unrelated = Unrelated + subUn;

    if subCor > subUn
        flagC = flagC + 1;
    end

    if subCor < subUn
        flagU = flagU + 1;
    end

    % tag = Tinit:1:N-p+1;
    % figure(3)
    % hold on
    % plot(tag,MartingaleC(Tinit:N-p+1))
    % plot(tag,MartingaleN(Tinit:N-p+1))
    % hold off

end

Correlated = Correlated/times

Unrelated = Unrelated/times


maxY = max(abs(y))

% flagC
% flagU
tspan = toc;





tag = 1:1:times;

plot(tag,CorreEach);
hold on
plot(tag,UnreEach);






function Aug = Augment(y,N,p)
    
     Aug = zeros(p,N-p+1);

     for i = 1:N-p+1

         Aug(:,i) = y(i:i+p-1)';
     
     end

end



