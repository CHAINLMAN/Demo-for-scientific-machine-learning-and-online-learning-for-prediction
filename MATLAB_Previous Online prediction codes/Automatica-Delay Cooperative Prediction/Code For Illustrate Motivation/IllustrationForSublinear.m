d1 = 1;

d2 = 2;

dsqrt = 5;

N = 10000;

x =1:N;

y1 = d1*x + dsqrt*sqrt(x);

y2 = d2*x - dsqrt*sqrt(x);

y3 = d1*x;

y4 = d2*x;

LW = 2.5;
LWlabel = 2;
fZ = 30;
fZlegend = 25;
fZlabel = 30;
region = 2:21;

figure(1)
hold on
plot(x,y1,'--','LineWidth',LW)
plot(x,y2,'--','LineWidth',LW)
plot(x,y3,'-','LineWidth',LW)
plot(x,y4,'-','LineWidth',LW)
legend('Hlow','Hhigh','Elow','Ehigh')
legend('Location', 'best');
grid on
