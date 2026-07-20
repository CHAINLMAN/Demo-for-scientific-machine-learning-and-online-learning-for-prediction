scale = 1000;
times = 1000;

martin = zeros(1,times);
martinU = zeros(1,times);
Smartin = zeros(1,times);
SmartinU = zeros(1,times);

N = 10000000;

% Const = zeros(N-1);

rho = 0.4;
truncate = 10;

% for i = 1:N-1
% 
%     for j = 1:N-i
% 
%         Const(i+j-1,j) = rho^(j-1);
% 
%     end
% 
% end
% Const = eye(N-1);

% Const = tril(rand(N-1));

for i = 1:times

    e = sqrt(scale)*randn(1,N);

    z = 100*rand(1,N-1);

    y = e(1:N-1)';

    martin(i) = e(2:N)*y*sqrt(pinv(y'*y));

    martinU(i) = e(2:N)*z'*sqrt(pinv(z*z'));

    Smartin(i) = martin(i)^2;

    SmartinU(i) = martinU(i)^2;

end

tag = 1:1:times;
plot(tag,martin)
hold on
plot(tag,martinU)
sum(martin)
sum(martinU)
% norm(martin)
% norm(martinU)

sum(Smartin)/times

sum(SmartinU)/times