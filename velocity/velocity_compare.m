%空间平均速度
figure,
detect_length=50;
space_interval=0.25*detect_length:detect_length:detect_length*12.25;
y=zeros(13,1);
for lane =1:5
    avr_space_v(13,lane)=NaN;
    for i=1:13
        y(i)=6-lane;
    end
    patch(space_interval,y,avr_space_v(:,lane),'EdgeColor','interp','Marker','.','MarkerFaceColor','flat','linewidth',12); 
    hold on
    colorbar;
end
axis ([-10 650 0 6]);
daspect([5 0.3 1])
grid on
title(sprintf('5 Lanes Space Average Velocity Comparision'))
xlabel('Space Interval(m)')
ylabel('Lane ID')
%时间平均速度
figure,
for lane =1:5
    avr_v(13,lane)=NaN;
    for i=1:13
        y(i)=6-lane;
    end
    patch(space_interval,y,avr_v(:,lane),'EdgeColor','interp','Marker','.','MarkerFaceColor','flat','linewidth',12); 
    hold on
    colorbar;
end
axis ([-10 650 0 6]);
daspect([5 0.3 1])
grid on
title(sprintf('5 Lanes Time Average Velocity Comparision'))
xlabel('Space Interval(m)')
ylabel('Lane ID')
