function [yh,sigma,P,xhat,fedA] = KalmanDelayedPredictor(A,C,Ca,Q,R,Ra,y,y1,x0,d)
   [m,~] = size(A); 
   [mn,step] = size(y);
   Cbar = [C;Ca];
   Rbar = blkdiag(R,Ra);
   Pbar = dare(A',Cbar',Q,Rbar);
   ybar = [y;y1];
   Lbar = A * Pbar * Cbar' * pinv(Cbar * Pbar * Cbar' + Rbar);

   L = cell(1,d);
   P = Pbar;
   for i = 1:d
       L{1,i} = A * P * C' * pinv(C * P * C' + R);
       P = A*P*A'+Q-A*P*C'*pinv(C*P*C'+R)*C*P*A';
   end

   fedA = A - Lbar*Cbar;
   sigma = max(abs(eig(fedA)));
   
   x0h = x0 + mvnrnd(zeros(m,1),Pbar)'; 
   xh = zeros(m,step);
   xh(:,1) = x0h;
   for i = 2:step
       xh(:,i) = A*xh(:,i-1)+Lbar*(ybar(:,i-1)-Cbar*xh(:,i-1));     
   end 

   yh = zeros(mn,step);
   xhat = zeros(m,step);
   
   for i = 1:step-d
       
       xhat(:,i+d) = Multistep(xh(:,i),y(:,i:i+d-1),L,A,C,d);

       yh(:,i+d) = C * xhat(:,i+d);
   end 

   % P = C*P0*C'+R;

end




function xh = Multistep(xh0,y,L,A,C,d)
     xh = xh0;

     for i = 1:d
         
         xh = A * xh + L{1,i}*(y(:,i) - C*xh);

     end

end