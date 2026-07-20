times = 100000;

tic

rho = 0.999;
for i = 1:times

    r = rho^10000;

end

t1 = toc;

tic
rho = 0.999;
for i = 1:times

    r = rho^10;

end

t2 = toc;