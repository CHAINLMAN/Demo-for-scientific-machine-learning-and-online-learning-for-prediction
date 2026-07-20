step = 68;

detYY = zeros(1,step);

N = 20000;

[y,e] = Autoregressive(N,10,R,rho);

for i = 1:step
  
    Y = AugmentH(y,ceil(i*N/step),i,1);

    detYY(i) = log(det(Y*Y'));

end

tag = 1:1:step;
plot(tag,detYY)


% success = zeros(1,61);
% for i = 1:61
% 
%     success(i) = detYY(i+1) - detYY(i);
% 
% end





    function Aug = AugmentH(y,N,p,H)
    
     Aug = zeros(p,N-p-H+2);

     for i = 1:N-p-H+2

         Aug(:,i) = y(i:i+p-1)';
     
     end

end