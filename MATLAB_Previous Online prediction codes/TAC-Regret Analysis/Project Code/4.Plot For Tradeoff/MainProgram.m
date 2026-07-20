%data collection
m = 3;
p = ceil(beta * log(N/2));
% [yh2,sigma2,P,xhat,fedA,L] = KalmanFilter(A,C2,Q,R2,y2,x0);
scaling = 0.5;
gammaa = sigma2:0.03:1;
ll = length(gammaa);

regressionE = zeros(times,ll);
regularizationE = zeros(times,ll);

for kk = 1:times
e = y(m*kk-m+1:m*kk,:)-yhat(m*kk-m+1:m*kk,:);
yt = y(m*kk-m+1:m*kk,:);
Z1 = zeros(p*m,N-p);
V = cell(1,N-p);
for i = 1:N-p
    zz = zeros(m*p,1);
    for l = 1:p
        zz((l-1)*m+1:l*m,1) = yt(:,i+p-l);
    end
    Z1(:,i) = zz;
end

% for i =1:N-p
%     V{1,i} = Z1(:,1:i)*Z1(:,1:i)';
% end




for i = 1:length(gammaa)
    vec = zeros(1,p);
    for j = 1:p
        vec(j) = 1/(gammaa(i)^(j-1));
    end
    Dp = kron(diag(vec),eye(m));
    regressionE(kk,i) = norm(e(:,p+1:N)*Z1'*pinv(lambda*Dp^2+Z1*Z1')*Z1 * e(:,p+1:N)');
    regularizationE(kk,i) = norm(lambda^2 * Ghat * Dp^(2) * pinv(lambda*Dp^2+Z1*Z1') * Dp^(2)*Ghat');
end

end
mregressionE = mean(regressionE);
varregressionE = sqrt(var(regressionE));
uRegression = mregressionE + scaling*varregressionE;
lRegression = mregressionE - scaling*varregressionE;

mregularizationE = mean(regularizationE);
varregularizationE = sqrt(var(regularizationE));
uRegularization = mregularizationE + scaling*varregularizationE;
lRegularization = mregularizationE - scaling*varregularizationE;
% figure(1)
% yyaxis left
% semilogy(gammaa,regressionE,'-ob','LineWidth',2)
% set(gca, 'YScale', 'log')
% ylabel('Regression Error')
% hold on 
% yyaxis right
% semilogy(gammaa,regularizationE,'-or','LineWidth',2)
% ylabel('Regularization Error')
% set(gca, 'YScale', 'log')
% grid on
% legend('Regression','Regularization')
% xlabel('\gamma')
% 
% figure(2)
% semilogy(gammaa,regressionE+regularizationE,'-ob','LineWidth',2)


% V = cell(1,N/2);
% 
% for i = 1:N/2
%     Select = Z1(:,1:i+N/2-p-1);
%     V{1,i} = lambda * eye(m*p) + Select * Select';
% end
% 
% testNum = 6100;
% norm((G2-G2hat)*Z1(:,testNum-p) - C2*fedA^(p)*xhat(:,testNum-p))


% AccumulationError;
% RegressionError;