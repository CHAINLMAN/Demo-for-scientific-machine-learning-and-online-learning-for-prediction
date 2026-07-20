function [y,e] = Autoregressive(N,y0,R,rho)

y = zeros(1,N);

e = randn(1,N);
% e = GenerateColoredNoise(0.5,R,N);

y(1) = y0;

% e(1) = sqrt(R) * randn(1);

e = sqrt(R) * e;

Rho = zeros(1,N);

for i = 1 : N
    
    Rho(i) = rho^i;

end

for i = 2:N
    
    parameter = flip(Rho(1:i-1));

    y(i) = parameter * y(1:i-1)' + e(i-1);

    % e(i) = sqrt(R) * randn(1);

end

end