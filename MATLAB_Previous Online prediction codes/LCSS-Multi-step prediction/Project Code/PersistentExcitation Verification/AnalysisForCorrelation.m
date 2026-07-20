v = 0.01*randn(1,N-1);

testvec = v+u(1:N-1);


u(1:N-1)*testvec'/(sqrt(testvec*testvec'))


