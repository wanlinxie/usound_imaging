function [F]=polar_image(I,radius_min,radius_max,angle)

clc;
close all;

% Plot the input data
figure(1)
image(I,'CDataMapping','scaled');
%title('Input Data)')

[M N]=size(I);

if(M>N) dim=M;
 else dim=N;
end
I=imresize(I,[dim dim]);
[M N]=size(I)
figure(2)
size(I)
%
% kernel = (1/16) .* [ 1 2 1; 2 4 2; 1 2 1];
% I = conv2(I, kernel);
%
%
I = medfilt2(I);
%
%
% kernel = [ 0 -1 0; -1 5 -1; 0 -1 0];
%kernel = 10*[ -1 -1 -1; -1 8 -1; -1 -1 -1];
% I = conv2(I, kernel);
%
% [~, threshold] = edge(I, 'sobel');
% fudgeFactor = 1.2;
% BWs = edge(I,'sobel', threshold * fudgeFactor);
%
% image(BWs,'CDataMapping','scaled');
% I = BWs;
image(I,'CDataMapping','scaled');
%colormap()
% I = I(1:end-2,1:end-2);
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
axis on
xlabel('X');
ylabel('Y');
zlabel('Z');
%title('Scanning Image')