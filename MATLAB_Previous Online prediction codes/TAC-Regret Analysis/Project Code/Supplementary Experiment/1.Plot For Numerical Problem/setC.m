function C = setC(mSensor)
    
    C(1,:) = [1,0,0];
    
    for j = 2:mSensor
        
        C(j,:) = 2*rand(1,3);

    end

end