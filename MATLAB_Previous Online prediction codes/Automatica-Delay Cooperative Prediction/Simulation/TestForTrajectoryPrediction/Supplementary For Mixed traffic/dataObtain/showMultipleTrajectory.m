
numberTraj = 10;
indexForPlot = randi([1,numberVehicle],1,numberTraj);

figure(1)

hold on
for i = 1:numberTraj

    cc = Trajectory{1,i};
    
    plot(cc(1,:),cc(2,:));

end

