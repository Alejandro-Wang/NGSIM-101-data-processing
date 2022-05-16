%空间平均速度是在道路的一段空间区域内车辆平均车速的平均值
%对路段进行切割，长度为50m的小区间，每个区间内获取平均通过时间，再求区间速度 
lane=1;
tempTable=eval(['T',num2str(lane)]);
car_id=tempTable(:,1);
frame_id=tempTable(:,2);
Y=tempTable(:,6);
Length=tempTable(:,9);
V=tempTable(:,12);
%车道长度,车头位置相减max(Y)-min(Y)+mean(Length)=648.7933176-5.5461408+4.44468833(m),直接处理为650m.
L=650;
detect_length=50;
uniframe_id=unique(frame_id);
unicar_id=unique(car_id);
sum_t=zeros(12,1);
sum_v=zeros(12,1);
n1=zeros(12,1);
n2=zeros(12,1);
%avr_space_v=zeros(12,5);
for i=1:length(unicar_id)
    y=Y(car_id==unicar_id(i));
    v=V(car_id==unicar_id(i));
    %T=frame_id(car_id==unicar_id(i));
    for loc=1:12 %分为12个时间段
        Location_start=loc*detect_length-detect_length;
        Location_over=loc*detect_length;  
        %存在中途换道的去掉
        if sum(y>=Location_start & y<=loc*detect_length)>0 && sum(y>Location_start+detect_length & y<=Location_over+detect_length)==0
            break
        else
            sum_t(loc)=sum_t(loc)+sum(y>Location_start & y<=loc*detect_length)+1; %思想是，求落在区间内的和
            n2(loc)=n2(loc)+1;
        end
    end
end

%avr_space_v(1,lane)=10*n(1)*(50-10)/sum_t(1);
%"掐头去尾"
% for loc =2:12
%     avr_space_v(loc,lane)=10*n(loc)*detect_length/sum_t(loc);
% end


%绘图
c=jet(10);
figure,
set(gcf,'unit','normalized','position',[0.2,0.2,0.5,0.5] )
bar(0.5*detect_length:detect_length:detect_length*11.5,avr_space_v(:,lane))
ylabel('Space Average Velocity (m/s)')
axis ([-25 650 0 20])
%legend('Occupancy','Density')
title(sprintf('Space Average Velocity on Lane #%d', lane));
xlabel('Dectect Interval(m)')
grid on;

