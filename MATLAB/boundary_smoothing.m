% Miguel Angel Gutierrez
% mag2293@columbia.edu
% Creative Machines Lab @ Columbia University
%
% June 14, 2017
%
% INPUT: 1D matrix - adjusted_angles; integer - angle_count; integer -
% sample_count; 2D matrix - grid; integer - grid_width; integer - grid_height;
% integer - grid_resoltution
% OUTPUT: 2D matrx - grid
%
% boundary_smoothing() creates higher resolution boundaries around the plot
% based on the boundaries of the measured data, and then deletes
% interpolated data that exists outside the boundaries of measured data. 

function [grid] = boundary_smoothing(adjusted_angles, angle_count, sample_count, grid, grid_width, grid_height, grid_resolution)
%% Smoothing the Left and Right Boundaries of the Image
boundary_count = sample_count * grid_resolution;
boundary_line = ones( boundary_count, 2);

% Right Side
% Build the boundary line
rho = (1 : boundary_count)';
boundary_line(:,1) = rho .* cosd(adjusted_angles(1));
boundary_line(:,2) = rho .* sind(adjusted_angles(1));
boundary_line = round(boundary_line)

% Center position_matrix values
boundary_line(:,1) = boundary_line(:,1) + (grid_width/4)

% Start zeroing values
for i = 1:boundary_count
    r = boundary_line(i,2);
    %disp('here1')
    %boundary_line(i,1)
    %grid_height
    for c = boundary_line(i,1):grid_height
        %disp('here2')
        grid(r,c) = 100;
    end
end

% Left Side
% Build the boundary line
rho = (1 : boundary_count)';
boundary_line(:,1) = rho .* cosd(adjusted_angles(angle_count));
boundary_line(:,2) = rho .* sind(adjusted_angles(angle_count));
boundary_line = round(boundary_line);

% Center position_matrix values
boundary_line(:,1) = boundary_line(:,1) + (grid_width/2);

% Start zeroing values
for i = 1:boundary_count
    r = boundary_line(i,2);
    for c = 1:boundary_line(i,1)
        grid(r,c) = 0;
    end
end

% Upper Boundary
boundary_angles = linspace(min(adjusted_angles), max(adjusted_angles), boundary_count)';

% Build the boundary line
rho = 1;
boundary_line(:,1) = (rho * grid_resolution) .* cosd(boundary_angles);
boundary_line(:,2) = (rho * grid_resolution) .* sind(boundary_angles);
boundary_line = round(boundary_line);

% Center position_matrix values
boundary_line(:,1) = boundary_line(:,1) + (grid_width/2);

% Start zeroing values
for i = 1:boundary_count
    c = boundary_line(i,1);
    for r = 1:boundary_line(i,2)
        grid(r,c) = 0;
    end
end

% Lower Boundary
boundary_angles = linspace(min(adjusted_angles), max(adjusted_angles), boundary_count)';

% Build the boundary line
rho = sample_count;
boundary_line(:,1) = (rho * grid_resolution) .* cosd(boundary_angles);
boundary_line(:,2) = (rho * grid_resolution) .* sind(boundary_angles);
boundary_line = round(boundary_line);

% Center position_matrix values
boundary_line(:,1) = boundary_line(:,1) + (grid_width/2);

% Start zeroing values
for i = 1:boundary_count
    c = boundary_line(i,1);
    for r = boundary_line(i,2):grid_height
        grid(r,c) = 0;
    end
end