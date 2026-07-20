LW = 5;
LWlabel = 2;
fZ = 35;
fZlegend = 35;
fZlabel = 30;


gammaa = sigma2:0.03:1;
tic
ll = length(gammaa);

indexx = [sigma2,0.6,0.8,1];
colorSlightOrange = 1/255*[255, 246, 236];
myColor = [colorSlightBlue;colorSlightRed;colorSlightOrange];

Accumulation = zeros(ll,N);
DataStorage = cell(1,3);
AccumuForPlot = zeros(times,Epoh);
for l = 1:4
     vec = zeros(1,p);

     for j = 1:p
    
         vec(j) = 1/(indexx(l)^(j-1));

     end
     
     Dp = diag(vec);
     

     for t = 1:times

      yt = y(m*t-m+1:m*t,:);
      Z1 = zeros(p*m,N-p);
      
     for i = 1:N-p
         zz = zeros(m*p,1);
         for j = 1:p
             zz((j-1)*m+1:j*m,1) = yt(:,i+p-j);
         end
         Z1(:,i) = zz;
     end

      for i = 1:Epoh
  
         pp = ceil(beta*log(Tini*2^(i-1)));
         Dpp = kron(Dp(1:pp,1:pp),eye(m));

         for k = Tini*2^(i-1)+1:Tini*2^(i)

            vecc = Z1(m*(p-pp)+1:m*p,k-pp);
            mid = Z1(m*(p-pp)+1:m*p,1:k-pp-1);
            Mid = lambda*Dpp*Dpp+mid*mid';
            Accumulation(l,k) = Accumulation(l,k-1) + vecc'*pinv(Mid)*vecc;
         
         end
         
         AccumuForPlot(t,i) = Accumulation(l,k);


      end

     end

     mAccu = mean(AccumuForPlot);
     varAccu = sqrt(var(AccumuForPlot));
     uAccu = mAccu + varAccu;
     lAccu = mAccu - varAccu;
     
     % tag = 1:1:Epoh;
     % figure(2)
     % fill([tag, fliplr(tag)], [lAccu, fliplr(uAccu)],myColor(l,:),'EdgeColor','none');
     % hold on
     % h(l) = semilogy(tag,mAccu,'-o','LineWidth',LW);

     DataStorage{1,l} = [mAccu;uAccu;lAccu];

end

% tspan = toc;
% tag = Tini+1:1:N;
% 
% grid on
% xlabel('Epoch Number','Interpreter','latex','FontSize',fZlabel)
% ylabel('Accumulation Error','Interpreter','latex','FontSize',fZlabel)
% legend([h(1),h(2),h(3)],'$\gamma=\rho(A-LC)$','$\gamma=0.8$','$\gamma=1$','Fontsize',fZlegend)
% 
% % figure(2)
% % plot(tag,Accumulation(1,Tini+1:N),'LineWidth',2)
% % hold on
% % plot(tag,Accumulation(9,Tini+1:N),'LineWidth',2)
% % plot(tag,Accumulation(18,Tini+1:N),'-y','LineWidth',2)
% % xlabel('time step','FontSize',12)
% set(gcf, 'Units', 'inches', 'Position', [1, 1, 16, 9]);
% ax = gca;
% ax.FontSize = fZlabel;
% set(gca,'TickLabelInterpreter','latex' ,'FontSize', fZ, 'LineWidth', LWlabel);