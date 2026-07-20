function [y,u,x] = ProcessWithU(A,B,C,Q,R,x0,N)
     [n,~] = size(A);
     [m,~] = size(C);
     [~,nu] = size(B);
     y = zeros(m,N);
     u = zeros(nu,N);
     x = zeros(n,N);
     VarU = eye(nu);
     for i = 1:N
         y(:,i) = C * x0 + mvnrnd(zeros(m,1),R)';
         x(:,i) = x0;
         u(:,i) = mvnrnd(zeros(nu,1),VarU)';
         x0 = A * x0 + B * u(i) + mvnrnd(zeros(n,1),Q)';
     end
end