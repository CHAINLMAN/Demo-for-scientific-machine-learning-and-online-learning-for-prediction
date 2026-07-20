function Pos = setPosition(m,r)
   Pos = cell(1,m);
   a = r;
   pp = rand(2,m);
   for i = 1:m
       Pos{1,i} = a * pp(:,i);
   end
end