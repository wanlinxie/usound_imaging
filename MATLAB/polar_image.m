function [F]=polar_image(I,radius_min,radius_max,angle)

clc;
close all;

% Plot the input data
figure(1)
imshow((I));
title('Input Data)')

[M N]=size(I);

%rotate pi/2
I=imrotate(I,90);

%From cartesian to polar
theta_max=angle;

step_theta=theta_max/(N-1);
step_r=(radius_max-radius_min)/(M-1);
[r,theta] = meshgrid(radius_min:step_r:radius_max, -theta_max/2:step_theta:theta_max/2);
xx=-r.*cos(theta*pi/180)-radius_min;
yy=-r.*sin(theta*pi/180)-radius_min;

figure(2);
F=surface(yy,xx,im2double(I),'edgecolor','interp'); 
colormap()
axis off
title('Image in polar coordinates')