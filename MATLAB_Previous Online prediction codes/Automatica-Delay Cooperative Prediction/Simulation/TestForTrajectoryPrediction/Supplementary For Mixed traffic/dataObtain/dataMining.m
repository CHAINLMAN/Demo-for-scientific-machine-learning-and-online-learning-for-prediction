horizon = length(Xlabel);

initialPosi = 2;
endPosi = 2;

flag = 1;

iniPos = [];
endPos = [];

for i = 2: horizon
    
    if IndexOfVehicle(initialPosi) == IndexOfVehicle(i)
        
        continue;
    
    end

    endPosi = i - 1;
    
    iniPos = [iniPos, initialPosi];

    endPos = [endPos, endPosi];

    initialPosi = i;

end

numberVehicle = length(iniPos);

Trajectory = cell(1,numberVehicle);

for i = 1:numberVehicle

    Trajectory{1,i} = [Xlabel(iniPos(i):endPos(i))';Ylabel(iniPos(i):endPos(i))'];

end