times = 2000;

flag = 0;

N = 10000;

ratio = 0.01;

for i = 1:times

    e = randn(1,N);

    vare = e*e';

    if vare < (1-ratio)*N || vare > (1+ratio)*N

        flag = flag + 1;

    end

end