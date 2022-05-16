c=jet(5);
figure,
set(gcf,'unit','normalized','position',[0.2,0.2,0.5,0.5] )
for lane=1:5    
    tempTable=eval(['T',num2str(lane)]);
    car_id=tempTable(:,1);
    frame_id=tempTable(:,2);
    Y=tempTable(:,6);
    Length=tempTable(:,9);
    %车道长度,车头位置相减max(Y)-min(Y)+mean(Length)=648.7933176-5.5461408+4.44468833(m),直接处理为650m.
    L=650;
    uniframe_id=unique(frame_id);
    %设置检测间隔,
    interval=30;
    times=floor(888/interval)-1;
    detect_time=zeros(times,1);
    occupancy=zeros(times,1);
    q=zeros(times,1);
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
        q(i)=sum_q*1000/L; %密度单位：pcu/km
        occupancy(i)=100*sum_l/L;
    end
    %绘图
    p=plot(detect_time/10,q,'-','linewidth',2); 
    p.Marker = '+';  
    hold on
end
grid on
ylabel('Density(pcu/h)')
axis([90 810 15 55])
legend('lane 1','lane 2','lane 3','lane 4','lane 5')
title(sprintf("5 Lanes' Space Density Comparision"))
xlabel('Detected Time(s)')