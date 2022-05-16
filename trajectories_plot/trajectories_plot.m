%load('trajectories.mat')
lane = 3;
cardata=eval(['T',num2str(lane)]);
car_id=cardata(:,1);
unicar_id=unique(car_id);
%颜色均匀分布
N=0;
for i=1:length(unicar_id)
        plotTable=cardata(car_id==unicar_id(i),:);
        x=plotTable(:,4);
        y=plotTable(:,6);
        v=plotTable(:,12); 
        v(end)= NaN;    %颜色参数的最后一个值设为空，便于顶点赋颜色
        norm=ceil(25*normalize(v,'range'))+1;%归一化
        patch(x,y,v,'EdgeColor','interp','Marker','.','MarkerFaceColor','flat','linewidth',0.1);   
        colorbar;
end
axis auto;
grid on
axis([-10 900 0 660])
daspect([0.4 1 1])
title(sprintf('NGSIM I-101 Trajectory on Lane %d', lane));
xlabel('Time(s)')
ylabel('Vertical position (feet)')