function g = ComputeNorm(G,m,p)
   
   g = zeros(1,p);
   
   for i = 1:p
      
      mind = G(1:m,m*(i-1)+1:m*i);
      g(i) = trace(mind*mind');

   end

end