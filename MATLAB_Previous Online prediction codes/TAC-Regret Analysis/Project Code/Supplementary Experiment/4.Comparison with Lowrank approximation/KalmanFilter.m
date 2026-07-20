function [yh,sigma] = KalmanFilter(A,C,Q,R,y,x0)
   [m,~] = size(A); 
   [mn,step] = size(y);
   P0 = eye(m);
   times = 1000;
   for i = 1:times
       P0 = A*P0*A'+Q-A*P0*C'*pinv(R+C*P0*C')*C*P0*A';
   end
   L = A * P0 * C' * pinv(C * P0 * C' + R);
   sigma = max(abs(eig(A-L*C)));
   x0h = x0 + mvnrnd(zeros(m,1),P0)'; 
   xh = x0h;
   y0 = C * x0h;
   yh = zeros(mn,step);
   yh(:,1) = y0;
   for i = 2:step
       xh = A*xh+L*(y(:,i-1)-C*xh);
       yh(:,i) = C * xh;
   end   
end