times = 10;
m = 1;
tic

lambda = 1;

beta = 0.3:0.1:2;
gamma = 1;

numBeta = length(beta);

Tini = 30;

%collect the regret of different forgetting factor

Performance = zeros(3,numBeta);
PerformanceT = zeros(3,times);

cc = rand(1);

indeX = ceil(cc * 1992);

y = Trajectory{1,1848};

for l = 1:numBeta
  
    beta(l)
  
    for i = 1:times

        len = length(y(1,:));

        Epoch = floor(log(len/Tini)/log(2));

        N = len;

        y10 = y(:,1:N);
   
        noiseG = 10 * [randn(1,N);randn(1,N)];
        y1 = y10 + noiseG;
        noiseG = 10 * [randn(1,N);randn(1,N)];
        y2 = y10 + noiseG;


        [yReg,G1] = RegressionFilterWithForgettingModified(y1,2*beta(l),lambda,Tini,Epoch,N,1);
        [yRegD] = RegressionFilterWithDelay(y1,y2,beta(l),lambda,Tini,Epoch,N,1,1,1);
        [yRegD2] = RegressionFilterWithDelay(y1,y2,beta(l),lambda,Tini,Epoch,N,1,1,2);
   

    %Performance of Online Filter (in terms of regret)
        ydif = y1(:,Tini+1:N)-yReg(:,Tini+1:N);
        PerformanceT(1,i) = trace(ydif*ydif');
   
   
        ydif = y1(:,Tini+1:N)-yRegD(:,Tini+1:N);
        PerformanceT(2,i) = trace(ydif*ydif');

        ydif = y1(:,Tini+1:N)-yRegD2(:,Tini+1:N);
        PerformanceT(3,i) = trace(ydif*ydif');

     end


%take average over different times

 Performance(1,l) = 1/times * sum(PerformanceT(1,:));


 Performance(2,l) = 1/times * sum(PerformanceT(2,:));

 Performance(3,l) = 1/times * sum(PerformanceT(3,:));

end

tspan = toc;

figure(1)
hold on
plot(beta,Performance(1,:))
plot(beta,Performance(2,:))
plot(beta,Performance(3,:))