function H = HankelMatrix(T)
   
   H = zeros(T);
   
   for i = 1:T
       for j = 1:T
           H(i,j) = (1+(-1)^(i+j))/2/(i+j-1);
       end
   end
end