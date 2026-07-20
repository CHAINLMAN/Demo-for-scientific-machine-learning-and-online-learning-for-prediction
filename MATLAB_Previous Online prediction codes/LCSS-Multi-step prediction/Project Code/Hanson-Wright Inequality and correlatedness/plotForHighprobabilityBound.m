times = 5000;

martin = zeros(1,times);
martinU = zeros(1,times);
Smartin = zeros(1,times);
SmartinU = zeros(1,times);

N = 1000;

Const = zeros(N-1);

rho = 0.4;
for i = 1:N-1

    for j = 1:N-i

        Const(i+j-1,j) = rho^(j-1);

    end

end
% Const = eye(N-1);

% Const = tril(rand(N-1));

for i = 1:times

    e = sqrt(i)*randn(1,N);

    z = 100*rand(1,N-1);

    y = Const*e(1:N-1)';

    martin(i) = e(2:N)*y*sqrt(pinv(y'*y));

    martinU(i) = e(2:N)*z'*sqrt(pinv(z*z'));

    Smartin(i) = martin(i)^2;

    SmartinU(i) = martinU(i)^2;

end

c = 2.2;
const = c * log(times*100);
tag = 1:1:times;
plot(tag,const*ones(1,times))
hold on
plot(tag,Smartin)