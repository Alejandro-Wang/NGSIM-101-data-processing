% clc;
% T0=trajectories;
% 
% %时间戳转换 ，单位ms--s
% T0(:,4)=(T0(:,4)-1118846979700)/1000; 
% %位移、速度、加速度、车头距单位转换为国际标准单位 英尺
% T0(:,6)=T0(:,6)*0.3048;
% T0(:,9)=T0(:,9)*0.3048;
% T0(:,10)=T0(:,10)*0.3048;
% T0(:,12)=T0(:,12)*0.3048;
% T0(:,13)=T0(:,13)*0.3048;
% T0(:,17)=T0(:,17)*0.3048;
%关键参数列记录
car_id=T0(:,1);
frame_id=T0(:,2);
Y=T0(:,6);
Length=T0(:,9);
Width=T0(:,10);
V=T0(:,12);
A=T0(:,13);
Lane_id=T0(:,14);
pre_id=T0(:,15);
Space=T0(:,17);
Headway=T0(:,18);

%速度筛选
%histogram(V)
%加速度筛选
%histogram(A)

%车头时距小于0.5s,大于50s的明显不合理数据删去
T0(Headway>50 | Headway<0.3,:)=[];

Headway=T0(:,18);

%数据集最小车长为1.22m,认为车头间距小于1
T0(Space>100 | Space<1.5,:)=[];
Space=T0(:,17);
%histogram(Space)
%histogram(Headway);
%histogram(Length);
%histogram(Width);
%histogram(Space)
%按车道生成子文件便于后续处理
for i=1:8    
    eval(['T',num2str(i),'=','T0(T0(:,14)==i,:)'])
end