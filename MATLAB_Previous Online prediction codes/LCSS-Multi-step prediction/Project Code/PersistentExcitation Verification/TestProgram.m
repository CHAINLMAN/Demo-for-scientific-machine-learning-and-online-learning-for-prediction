N = 400000;

dimA = 1;

dimB = 1;

dimC = 1;

% A = rand(dimA);
% 
% A = 1/max(abs(eig(A)))*A;
% 
% B = rand(dimA,dimB);
% 
% C = rand(dimC,dimA);

% generate system parameters

A = 1;
B = 20;
C = 1;

W = rand(dimA);
W = orth(W);
D1 = eye(dimA);
Mid = D1;
Q = W*Mid*W';
R = eye(dimC);

x0 = rand(dimA,1);

u = zeros(dimB,N);

for i = 1:N

    u(:,i) = mvnrnd(zeros(dimB,1),eye(dimB))';

end

scale = 1;

u = scale*u;

[y,x] = ProcessWithU(A,B,C,Q,R,x0,N,u);

p = 5;

Y = AugmentH(y,N,p,1);
U = AugmentH(u,N,p,1);
Aug = [Y;U];
Cross = U*Y';
BigMatrix = Aug*Aug';

min(eig(Aug*Aug'))

min(eig(U*U'))









function Aug = AugmentH(y,N,p,H)
    
     [m,~] = size(y);
     
     Aug = zeros(m*p,N-p-H+2);

     for i = 1:N-p-H+2

         zz = zeros(m*p,1);

         for j = 1:p

             zz((j-1)*m+1:j*m,1) = y(:,i+j-1);
         
         end

         Aug(:,i) = zz;

     end

end