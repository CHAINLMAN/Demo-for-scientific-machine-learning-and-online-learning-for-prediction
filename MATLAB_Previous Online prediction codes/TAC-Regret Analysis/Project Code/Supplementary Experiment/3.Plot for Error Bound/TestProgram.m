dim = 3;
m = 1;
tic
% A = rand(dim);
% A = 1/max(abs(eig(A)))*A;%normalization
% T = 0.1;
T = 1;
A = [1,T,0;0,1,T;0,0,0.9];
C = [1,0,0];
Q = eye(3);
R = 1;
P0 = dare(A',C',Q,R);
L = A * P0 * C' * pinv(C * P0 * C' + R);
feedback = A - L*C;

Epoh = 9;
lambda = 1;
Tini = 50;
N = Tini * (power(2,Epoh));
x0 = zeros(dim,1);

%obtian data
[xstate] = Process(A,Q,x0,N);
[y] = observationProcess(xstate,C,R);
[yh,sigma2,Pc,xhat,fedA] = KalmanFilter(A,C,Q,R,y,x0);

e = y-yh;
covR = cov(e');
sigmaR = max(eig(covR));
delta = 0.01;

times = 1;
plotD = zeros(2,times);
for g = 1:times
   beta = 4;
   detV = zeros(1,Epoh);
   HWbound = zeros(1,Epoh);
   regular = zeros(1,Epoh);
   for k =1:Epoh
      tail = Tini*2^k;
      p = ceil(beta*log(tail));
      Z1 = zeros(p*m,tail);
      for i = 1:tail-p+1
         zz = zeros(m*p,1);
         for l = 1:p
           zz((l-1)*m+1:l*m,1) = y(:,i+p-l);
         end
         Z1(:,i) = zz;
      end
      Vv = lambda * eye(m*p) + Z1(:,1:tail-p-1)*Z1(:,1:tail-p-1)';
      detV(k) = sigmaR*(log(det(Vv))+log(1/delta));
      HWbound(k) = sigmaR * (2*p + 16/3*log(1/delta) + 16/3*log(tail^2));
      vec = e(:,p+1:tail)*Z1(:,1:tail-p)';
      regular(k) = norm(vec * pinv(Vv) * vec');
   end  
   
   % 
   % for i = 1:N/2
   %     Select = Z1(:,1:i+N/2-p-1);
   %     V{1,i} = lambda * eye(m*p) + Select * Select';
   %     detV(i) = sigmaR*(log(det(V{1,i}))+16/3*log(1/delta));
   %     HWbound(i) = sigmaR * (p + 16/3*log(1/delta) + 16/3*log((i+N/2)^2));
   % end

   % bx = C*fedA^p * xhat;
   % 
   % BiasAccumulation = cell(1,N/2);
   % for i = 1:N/2
   %    BiasAccumulation{1,i} = bx(:,1:i+N/2-p-1)*Z1(:,1:i+N/2-p-1)' * pinv(sqrtm(V{1,i}));
   % end


   % for i = 1:N/2
   %     vec = e(:,p+1:i+N/2-1)*Z1(:,1:i+N/2-p-1)';
   %     regular(:,i) = vec * pinv(V{1,i}) * vec';
   % end
   
   % WholeBiasError = regular - bx(:,N/2-p+1:N-p);
   % plotD(1,g) = 2/N*sum(abs(regular(1:N/2)));
   % plotD(2,g) = 2/N*sum(abs(WholeBiasError));
end

tag = 1:1:Epoh;
hold on
plot(tag,detV);
plot(tag,HWbound);
plot(tag,regular);

% WholeBiasError = Bias - bx(:,N/2-p+1:N-p);
% trace(WholeBiasError*WholeBiasError')
% trace(Bias*Bias')
% trace(Bias*Bias')/trace(WholeBiasError*WholeBiasError')
% 
% 
% dd = zeros(1,p);
% for i = 1:p
%     dd(i) = (1/sigma2)^(i-1);
% end
% D = kron(diag(dd),eye(m));
% 
% trace(Z1'*pinv(lambda*eye(m*p)+Z1*Z1')*Z1)
% trace(Z1'*pinv(lambda*eye(m*p)*D*D+Z1*Z1')*Z1)
 

tspan = toc;

