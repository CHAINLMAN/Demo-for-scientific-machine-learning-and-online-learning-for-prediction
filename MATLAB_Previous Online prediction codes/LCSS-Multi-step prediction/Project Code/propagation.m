function [xp,yp] = propagation(x,u,A,B,C,Q,R)

     [m,~] = size(Q); 

     [my,~] = size(R);

     xp = A * x + B * u + mvnrnd(zeros(m,1),Q)';

     yp = C * xp + mvnrnd(zeros(my,1),R)';

end