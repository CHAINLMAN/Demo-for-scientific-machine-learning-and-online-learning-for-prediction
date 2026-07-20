function [yh,sigma,P,xhat,fedA] = KalmanPredictor(A,C,Q,R,y,x0,H)
   [m,~] = size(A); 
   [mn,step] = size(y);
   P0 = dare(A',C',Q,R);
   L = A * P0 * C' * pinv(C * P0 * C' + R);
   fedA = A - L*C;
   sigma = max(abs(eig(A-L*C)));
   x0h = x0 + mvnrnd(zeros(m,1),P0)'; 
   xh = x0h;
   y0 = C * x0h;
   yh = zeros(mn,step);
   xhat = zeros(m,step);
   xhat(:,H) = A^(H-1)*x0h;
   yh(:,1) = y0;
   for i = 2:step-H+1
       xh = A*xh+L*(y(:,i-1)-C*xh);
       xhat(:,H+i-1) = A^(H-1)*xh;
       yh(:,H+i-1) = C * A^(H-1) * xh;
   end 
   P = C*P0*C'+R;
end