function [yh,sigma,P,xhat,fedA] = MultipleKalmanPredictorWithU(A,B,C,Q,R,y,u,x0,H)
   
   [m,mb] = size(B); 
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

   BA = zeros(m,mb*(H-1));
   
   for i = 1:H
       BA(:,(i-1)*mb+1:i*mb) = A^(i-1)*B;
   end

   uaug = zeros(mb*H,1);

   for i = 1:H
       uaug((i-1)*mb+1:i*mb,1) = u(H-i+1);
   end

   xhat(:,H+1) = A^(H)*x0h+BA*uaug;

   yh(:,H+1) = C*xhat(:,H+1);
   

   for i = 2:step-H+1

       xh = A*xh+B*u(:,i-1)+L*(y(:,i-1)-C*xh);


       for j = 1:H

            uaug((j-1)*mb+1:j*mb,1) = u(H-j+i);

       end

       xhat(:,H+i) = A^(H)*xh+BA*uaug;


       yh(:,H+i) =  C* xhat(:,H+i);
   end 

   P = C*P0*C'+R;

end