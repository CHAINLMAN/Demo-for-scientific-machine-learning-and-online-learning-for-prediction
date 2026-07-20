function [y] = observationProcess(x,C,R)
     [~,N] = size(x); 
     [mn,~] = size(R);
     y = zeros(mn,N);
     for i = 1:N
         y(:,i) = C * x(:,i) + mvnrnd(zeros(mn,1),R)';
     end
end