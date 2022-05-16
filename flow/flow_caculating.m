format long g
%可以调节lane、Location_test、interval、detect_time
lane=6;
tempTable=eval(['T',num2str(lane)]);
car_id=tempTable(:,1);
frame_id=tempTable(:,2);
Y=tempTable(:,6);
%Flow（流量）：Calculated at the midpoint(300m) of each study section
Location_test=[100,350,600];  %检测位置 0-650m
%累积车辆数 (t=1起0.1s间隔)
uniframe_id=unique(frame_id);

%检测时间
detect_time=300;
%输入时间步长
interval=5; 

%traffic_flow=zeros(7200/detect_time,3,5); %k,l,lane
%绘图颜色
c=jet(3);
figure,
for l = 1:length(Location_test)
    loc=Location_test(l);
    for k=1:7200/detect_time  
        %流量计数N设置
        N=zeros(9000,1);
        N(start_time)=0;

        start_time=min(unique(frame_id((frame_id>detect_time*k)))); %检查时间设为60s
        %逐帧
        for t=start_time+interval:interval:start_time+detect_time+interval%max(uniframe_id)  %起始终止帧，调整步长
            N(t)=N(t-interval);
            index=find(frame_id==t);
            y2=Y(frame_id==t);
            y1=zeros(size(y2));

            j=0;
        %     index1=find(frame_id==t-interval);
            for i =1:length(index)%一次一个车 ,i=j
               j=j+1;
               if index(i)-interval<=0
                   y1(j)=0;
               elseif car_id(index(i)-interval)==car_id(index(i))%如果车在t-interval时标号不变
                    y1(j)=Y(index(i)-interval); 
               else %不存在
                   y1(j)=0;

               end
            end
            for i=1:length(index)
                if y1(i)<=loc && y2(i)>loc
                   N(t)=N(t)+1;
                    %N((t-min(uniframe_id))/interval+1)=N((t-min(uniframe_id))/interval+1)+1;
                end
            end
        %     N((t-min(uniframe_id))/interval+1)=N((t-min(uniframe_id))/interval);
        %     for i = 1:R(1)
        %         ID=car_id(i);
        %         if tempTable(,6)<=Location_test) & (tempTable(,6)>Location_test)
        %                         N((t-min(uniframe_id))/interval+1)=N((t-min(uniframe_id))/interval+1)+1;%sum(y2(:)>Location_test)-sum(y1(:)>Location_test); 
        %                         return
        %         end
        %     end
        end
        %计算流量
        traffic_flow(k,l,lane)=36000/detect_time*max(N);
        %sprintf('traffic flow on lane %d detected at %dm by interval %ds = %d veh/h',lane,Location_test,0.1*interval,traffic_flow(k))

    %     plot(k,traffic_flow(k))
    %     hold on;
    end
    p=plot(detect_time/600:detect_time/600:12,traffic_flow(:,l,lane),'-','linewidth',2);
    %p.Color= c(l);
    p.Marker = 'o';
    hold on
end
axis([0 12.5 0 3200])
legend('100m','350m','600m')
title(sprintf('Traffic Flow on Lane %d,dectected time %ds', lane,0.1*detect_time));
xlabel('Detected Time(min)')
ylabel('Flow(veh/h)')
grid on;
%逐车(废弃)
% unicar_id=unique(car_id);
% for i=1:length(unicar_id)
%     cardata=tempTable(car_id(:)==unicar_id(i),:);
%     y =cardata(:,6);   
%     for t=2:length(y)
%         if ((y(t-1)<=Location_test) && (y(t)>Location_test)) 
%              N=N+1;
%         end       
%     end
%     i
% end