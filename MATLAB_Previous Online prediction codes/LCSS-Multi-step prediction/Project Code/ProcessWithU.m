function [y,u,x] = ProcessWithU(A,B,C,Q,R,x0,Ubar,N)
     [m,~] = size(A); 
     y = zeros(N,1);
     u = zeros(N,1);
     x = zeros(N,m);
     for i = 1:N
         y(i) = C * x0 + mvnrnd(zeros(1),R);
         x(i,:) = x0';
         u(i) = -sign(y(i)) * Ubar;
         x0 = A * x0 + B * u(i) + mvnrnd(zeros(m,1),Q)';
     end
end