% clear all;
% close all;
% 
% load('trajectory_data.mat');

% The leader-follower pair we want to visualize
pair = 100;

% Lane can be chosen from 1 to 7.
lane = 1;

% Set a minimum number data points. We don't want too short trajectories. 
minTrajectoryLenght = 150;

% Call trajectory pair function.
dataTable = getTrajectoryPairs(T0, lane, minTrajectoryLenght);

% Print the trajectory for the first pair
plotTable = dataTable(dataTable(:,1)==pair,:);
figure,
% Plot leader vehicle trajectory 
plot(plotTable(:,4), plotTable(:,2),'b','linewidth',2);
hold on
%Plot following vehicle
plot(plotTable(:,4), plotTable(:,3),'r','linewidth',2);
legend('Leader vehicle','Follower vehicle')
title(sprintf('NGSIM I-80 Trajectory for Pair # %d on Lane %d', pair, lane));
xlabel('Frame number')
ylabel('Vertical position (m)')

%绘制跟随车辆的速度-车间距
mint=min(plotTable(:,4));
maxt=max(plotTable(:,4));
distance=zeros(length(plotTable(:,4)),1);
dx=zeros(length(plotTable(:,4)),1);
dy=zeros(length(plotTable(:,4)),1);
figure,

%Plot following vehicle
distance=plotTable(:,2)-plotTable(:,3)-4.5; %车长取平均4.5m算
p=plot(plotTable(:,5),distance,'-','linewidth',2);
%p.Color= 'cyan';
hold on
for t=mint:30:maxt
    text(plotTable(t,5),distance(t),num2str(ceil(t/10)));
end
title(sprintf('Following Car Velocity-Distance for Pair # %d on Lane %d', pair, lane));
xlabel('Velocity(m/s)')
ylabel('Following Distance (m)')
