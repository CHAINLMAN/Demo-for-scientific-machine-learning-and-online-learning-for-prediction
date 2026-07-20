function [x] = Process(A,Q,x0,N)
     [m,~] = size(A); 
     x = zeros(m,N);
     for i = 1:N
         x(:,i) = x0;
         x0 = A * x0 + mvnrnd(zeros(m,1),Q)';
     end
end