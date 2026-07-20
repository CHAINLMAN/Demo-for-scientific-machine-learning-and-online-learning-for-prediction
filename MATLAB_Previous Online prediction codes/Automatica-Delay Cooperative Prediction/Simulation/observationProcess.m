function [y] = observationProcess(x,C,R)
     [~,N] = size(x); 
     [mn,~] = size(R);
     
     y = zeros(mn,N);
     
     for i = 1:N
         
         % v = GenerateBoundedNoise(zeros(mn,1),R);

          v = mvnrnd(zeros(mn,1),R)';
         
         y(:,i) = C * x(:,i) + v;
     
     end
end