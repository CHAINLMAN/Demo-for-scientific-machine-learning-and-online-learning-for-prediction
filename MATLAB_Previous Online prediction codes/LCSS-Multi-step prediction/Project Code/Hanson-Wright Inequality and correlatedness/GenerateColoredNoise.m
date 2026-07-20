function w = GenerateColoredNoise(A,Q,N)

   [m,~] = size(A);

   w = zeros(m,N);

   w0 = mvnrnd(zeros(1,m),Q)';

   for i = 1:N

       w(:,i) = w0;

       w0 = A * w0 + mvnrnd(zeros(1,m),Q)';

   end


end