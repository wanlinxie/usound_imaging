function [F]=polar_image(I,radius_min,radius_max,angle)

clc;
close all;

% Plot the input data
figure(1)
image(I,'CDataMapping','scaled');
title('Input Data)')

[M N]=size(I);

if(M>N) dim=M;
 else dim=N;
end
I=imresize(I,[dim dim]);
[M N]=size(I)
figure(2)
image(I,'CDataMapping','scaled');
%colormap()

%rotate pi/2
I=imrotate(I,90);

%From cartesian to polar
theta_max=angle;

step_theta=theta_max/(N-1);
step_r=(radius_max-radius_min)/(M-1);
[r,theta] = meshgrid(radius_min:step_r:radius_max, -theta_max/2:step_theta:theta_max/2);
xx=-r.*cos(theta*pi/180)-radius_min;
yy=-r.*sin(theta*pi/180)-radius_min;
figure(3);
F=surface(yy,xx,im2double(I),'edgecolor','interp'); 
%plot3(yy,xx,1);
colormap()
axis off
title('Image in polar coordinates')