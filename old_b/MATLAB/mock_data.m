clear all; close all; clc
%%
% Generate mock data
mock_size = 10;
angle_sweep = 45;


[angle_count, sample_count, angles_file, intensity_file] = generate_data(mock_size, angle_sweep, 'random', 'nonideal');

% Initalize a blank grid
grid_resolution = 10;
[grid, grid_width, grid_height] = init_grid(mock_size, mock_size, grid_resolution);


        f = figure('Visible', 'off', 'rend','painters','pos',[10 10 1100 400]);
        
        subplot(1,2,1);
        image(grid1);
        title(['(1) Pre-Interpolation']);
        
        subplot(1,2,2);
        image(grid2);
        title(['(2) Post-Interpolation']);
        
disp('Done!');