function [y,x] = ProcessWithPrescribedU(A,B,C,Q,R,x0,u,N)
     [m,~] = size(A);
     [mn,~] = size(C);
     y = zeros(mn,N);
     x = zeros(m,N);
     for i = 1:N
         y(:,i) = C * x0 + mvnrnd(zeros(mn,1),R)';
         x(:,i) = x0;
         x0 = A * x0 + B * u(:,i) + mvnrnd(zeros(m,1),Q)';
     end
end