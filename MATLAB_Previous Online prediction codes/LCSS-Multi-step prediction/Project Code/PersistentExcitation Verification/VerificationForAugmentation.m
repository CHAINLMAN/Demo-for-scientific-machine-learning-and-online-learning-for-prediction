N = 10000;

e = randn(1,N);
eaug = 0.1*randn(1,N);

AugVec = [e;e]+[eaug;zeros(1,N)];

eig(AugVec*AugVec')

