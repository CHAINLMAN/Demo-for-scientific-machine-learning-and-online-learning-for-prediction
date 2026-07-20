function [x] = Process(A,Q,x0,N)
     
     [m,~] = size(A); 
    
     x = zeros(m,N);
     
     for i = 1:N
         x(:,i) = x0;

         % w = GenerateBoundedNoise(zeros(m,1),Q);

         w = mvnrnd(zeros(m,1),Q)';

         x0 = A * x0 + w;
     end
     
end