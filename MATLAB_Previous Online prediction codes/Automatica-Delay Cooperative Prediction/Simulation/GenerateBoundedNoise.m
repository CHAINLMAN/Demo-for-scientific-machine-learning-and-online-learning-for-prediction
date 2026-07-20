function w = GenerateBoundedNoise(m,Q)

   [dim,~] = size(m);

   w = m + sqrtm(12*Q)*(rand(dim,1)-0.5);

end