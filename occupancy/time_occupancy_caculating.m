%时间占有率的计算，字面意思上讲，是对虚拟探测器：有车占据时间求和/观测总时间
%可以调节lane、Location_test、detect_time 
%为精准测量，把interval设为0.1s
%探测器位置和计算流量一样的思路，在路段开头、中间、结尾各设一个
%这里我思考后觉得双线圈检测更好，我们有车长数据，结合车头位置、速度数据就能准确算出占据时间了。
lane=3;
%输入时间步长
interval=1; 
%检测位置
Location_test=[100,350,600]; 
%观测总时间1分钟
detect_time=600;

tempTable=eval(['T',num2str(lane)]);
car_id=tempTable(:,1);
frame_id=tempTable(:,2);
Y=tempTable(:,6);
Length=tempTable(:,9);
uniframe_id=unique(frame_id);
V=tempTable(:,12);
%设置每个检测器的检测次数
times=10;
T=zeros(times,1);
for k=600:6000/times:6000
    T(k/600)=k/10;
end
time_occupancy=zeros(times,3,5); %3维:检测时间，检测器位置，车道
figure;
for j=1:length(Location_test)   %共3个检测器
    loc=Location_test(j);
     %时间占有率-检测开始时间
    for k=600:6000/times:6000 %检测2-12分钟
        occupy_time=0;
       for t=k:interval:k+detect_time %开始-结束，逐帧
            index=find(frame_id==t);
            y=Y(frame_id==t); %车头位置列
            l=Length(frame_id==t); 
            v=V(frame_id==t); 
             for i=1:length(index)
                if (y(i)-l(i)<=loc && y(i)>=loc) || (l(i)<v(i)*interval*0.1 && y(i)-l(i)>loc && y(i)<=loc+10)   %核心算法是，车尾位置小于检查点，车头位置大于检查点，即为占有时间
                    occupy_time=occupy_time+l(i)/v(i); %认为在0.1s的间隔内，车为匀速通过
                    break
                end
             end
       end
       %计算时间占有率
       time_occupancy(k/600,j,lane)=100*occupy_time/detect_time;
       k
    end
    %画图
%     p=plot(T,time_occupancy(:,j,lane),'-','linewidth',2);
%     p.Marker = 'o';
%     hold on
end
% axis([0 700 0 50])
% legend('100m','350m','600m')
% title(sprintf('Time Occupancy on Lane %d,Dectected Time %ds', lane,0.1*detect_time));
% xlabel('Time(s)')
% ylabel('Time Occupancy(%)')
% grid on;