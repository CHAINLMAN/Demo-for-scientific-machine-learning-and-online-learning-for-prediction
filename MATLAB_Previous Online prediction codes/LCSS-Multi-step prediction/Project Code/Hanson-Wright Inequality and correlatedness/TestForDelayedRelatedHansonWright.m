times = 500;

N = 3000;

p = 10;

rho = 0.50;

R = 4;

Correlated = 0;
CorreEach = zeros(1,times);
Unrelated = 0;
UnreEach = zeros(1,times);

flagC = 0;
flagU = 0;
Tinit = 500;
H = 1;
tic
for i = 1:times

    i

    MartingaleC = zeros(1,N);
    MartingaleN = zeros(1,N);

    [y,e] = Autoregressive(N,10,R,rho);

    [r,weight] = GenerateHRelatedNoise(e,H);

    Y = AugmentH(y,N,p,H);

    z = 100 * randn(1,N);

    MidCor = pinv(Y * Y');
    Cross = r(p+H-1:N) * Y';
    subCor = Cross * MidCor * Cross';
    CorreEach(i) = subCor;

    Z = AugmentH(z,N,p,H);
    MidUn = pinv(Z * Z');
    Cross = r(p+H-1:N) * Z';
    subUn = Cross * MidUn * Cross';
    UnreEach(i) = subUn;


    % for j = Tinit:N-p+1
    % 
    %     YTrunc = Y(:,1:j-H+1);
    %     eTrunc = e(:,p+H-1:j+p-1);
    %     ZTrunc = Z(:,1:j-H+1);
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

    tag = Tinit:1:N-p+1;
    % figure(3)
    % hold on
    % plot(tag,MartingaleC(Tinit:N-p+1))
    % plot(tag,MartingaleN(Tinit:N-p+1))
    % hold off

end

Correlated = Correlated/times

Unrelated = Unrelated/times

log(det(Y*Y'))

% flagC
% flagU
tspan = toc;





tag = 1:1:times;

plot(tag,CorreEach);
hold on
plot(tag,UnreEach);






function Aug = AugmentH(y,N,p,H)
    
     Aug = zeros(p,N-p-H+2);

     for i = 1:N-p-H+2

         Aug(:,i) = y(i:i+p-1)';
     
     end

end



