Scale = 100;
times = 5000;
N = 1000;

martin = zeros(times,Scale);

martinInv = zeros(times,Scale);

for i = 1:Scale

    for j = 1:times

        e = sqrt(i)*randn(1,N);

        e1 = e(1:N-1);

        e2 = e(2:N);

        martin(j,i) = e2 * e1' / (e1*e1') * e1 * e2';

        martinInv(j,i) = e1 * e2' / (e2*e2') * e2 * e1';

    end

end

sumScale = sum(martin)/times;
sumScaleInv = sum(martinInv)/times;

tag = 1:1:Scale;

figure(1)
plot(tag,sumScale)
hold on
plot(tag,sumScaleInv)

