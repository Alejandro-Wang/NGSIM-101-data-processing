%可以调节lane、detect_time
%关键：占有率=车长求和/车道长度
lane=5;
tempTable=eval(['T',num2str(lane)]);
car_id=tempTable(:,1);
frame_id=tempTable(:,2);
Y=tempTable(:,6);
Length=tempTable(:,9);
%车道长度,车头位置相减max(Y)-min(Y)+mean(Length)=648.7933176-5.5461408+4.44468833(m),直接处理为650m.
L=650;
uniframe_id=unique(frame_id);
%设置检测间隔,
interval=10;
times=floor(888/interval)-1;
detect_time=zeros(times,1);
% occupancy=zeros(times,5);
% q=zeros(times,5);
for i =1:times   %共检测多少次，循环
    detect_time(i)=10*interval*i;
    index=find(frame_id==detect_time(i));
    l=zeros(length(index),1);
    sum_q=0;
    for k=1:length(index)
        l(k)=Length(index(k));
        %计算大车辆数
        if tempTable(index(k),11)==3
            sum_q=sum_q+1;
        end
    end
    %把‘truck’折合成标准车当量pcu为2.0
    sum_q=sum_q+length(index);
    sum_l=sum(l);
    q(i,lane)=sum_q*1000/L; %密度单位：pcu/km
    occupancy(i,lane)=100*sum_l/L;
end

%绘图
c=jet(3);
figure,
set(gcf,'unit','normalized','position',[0.2,0.2,0.5,0.5] )

yyaxis left
p=plot(detect_time/10,occupancy(:,lane),'-','linewidth',2);
p.Marker = 'o';
ylabel('Occupancy(%)')
axis([0 900 0 50])

yyaxis right
p=plot(detect_time/10,q(:,lane),'-','linewidth',2);
p.Marker = '+';
ylabel('Density(pcu/km)')
axis([90 810 0 60])
%p=plot(occupancy,'-','linewidth',2);

%legend('Occupancy','Density')
title(sprintf('Space Occupancy/Traffic Density on Lane #%d', lane));
xlabel('Detected Time(s)')
grid on;