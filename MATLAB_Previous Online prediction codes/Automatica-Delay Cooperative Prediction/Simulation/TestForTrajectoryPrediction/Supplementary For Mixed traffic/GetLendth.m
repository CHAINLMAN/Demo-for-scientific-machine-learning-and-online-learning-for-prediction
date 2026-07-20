[~,numberT] = size(Trajectory);

AllLen = zeros(1,numberT);

for i = 1:numberT

    Y = Trajectory{1,i};

    [~,cc] = size(Y);

    AllLen(i) = cc;

end