lane=5;
tempTable=eval(['T',num2str(lane)]);
car_id=tempTable(:,1);
Y=tempTable(:,6);
V=tempTable(:,12);
%时间平均速度，断面,50m一个检测
Location_test=zeros(floor(max(Y)/50),1);
%avr_v=zeros(floor(max(Y)/50),5);
for i=1:12
    sum_v=0;
    n=0;
    Location_test(i)=50*i;
    for j=1:length(Y)-1
        if(car_id(j)==car_id(j+1)) && Y(j)<=Location_test(i) && Y(j+1)>=Location_test(i) 
            sum_v=sum_v+V(j);
            n=n+1;
        end
    end
    avr_v(i,lane)=sum_v/n;
end
