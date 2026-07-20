function yh = KalmanFilterWithU(A,B,C,Q,R,y,x0,u)
   [m,~] = size(A); 
   step = length(y);
   P0 = eye(m);
   times = 100;
   for i = 1:times
       P0 = A*P0*A'+Q-A*P0*C'*pinv(R+C*P0*C')*C*P0*A';
   end
   L = A * P0 * C' * pinv(C * P0 * C' + R);
   x0h = x0 + mvnrnd(zeros(m,1),P0)'; 
   xh = x0h;
   y0 = C * x0h;
   yh = zeros(step,1);
   yh(1) = y0;
   for i = 2:step
       xh = A*xh+B*u(i-1)+L*(y(i-1)-C*xh);
       yh(i) = C * xh;
   end   
end