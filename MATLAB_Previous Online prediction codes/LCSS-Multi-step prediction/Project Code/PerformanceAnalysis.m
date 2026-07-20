function Perform = PerformanceAnalysis(y,yh)
    
     [~,len] = size(y);

     Perform = zeros(1,len);

     Perform(1) = norm(y(:,1) - yh(:,1))^2;
     
     for i = 2:len

         Perform(i) = Perform(i-1) + norm(y(:,i) - yh(:,i))^2;
     
     end



end