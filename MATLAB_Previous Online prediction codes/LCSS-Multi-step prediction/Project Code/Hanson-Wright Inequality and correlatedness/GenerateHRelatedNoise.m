function [r,weight] = GenerateHRelatedNoise(e,H)

   [m,N] = size(e);

   r = zeros(m,N);

   weight = rand(m,m*H);

   for i = 1:H

       r(:,i) = e(:,i);

   end

   for i = H+1:N

       rr = zeros(m,1);

       for j = 1:H

           rr = rr + weight(:,(j-1)*m+1:j*m) * e(i-j+1);
       
       end

       r(:,i) = rr;

   end


end