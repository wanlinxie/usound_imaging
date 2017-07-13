clear all; close all; clc
%%
% Generate mock data
mock_size = 25;
angle_sweep = 45;
[angle_count, sample_count, angles_file, intensity_file] = generate_data(mock_size, angle_sweep, 'boundary', 'gradient', 'ideal');

% Initalize a blank grid
grid_resolution = 10;
[grid, grid_width, grid_height] = init_grid(mock_size, mock_size, grid_resolution);

interpolation_grid = cell(grid_height, grid_width, 2);
interpolation_grid_nonideal = interpolation_grid;

%% UNDER CONSTRUCTION: IMAGE REFRESHING 
% Define sector-span beforehand.
% Maximum Value = (1/2) * angle_count
sector_span = 3;

% Iterate over each beam ("Read each beam one-by-one")
grid1 = grid;
grid2 = grid;
grid3 = grid;

EOF = 0;
count = 1;
intensity_buffer = [];
angle_buffer = [];
while ~EOF
    % Preprocess Line
    line = intensity_file(:, count)
    line = process_boundary(line, mock_size)
    
    % Enter lines into the buffer
    intensity_buffer = [intensity_buffer line];
    angle_buffer = [angle_buffer; angles_file(:, (count) )];

    angle_count = length(angle_buffer);
    sample_count = mock_size; % TBD by DAC

    % Once we have read an entire "sector span", start interpolation
    if(count >= sector_span)
        % Sort data
        %angle_buffer = angle_buffer';
        intensity_buffer = intensity_buffer';
        [angles, intensity] = sort_data(angle_buffer, intensity_buffer);
        intensity_buffer = intensity_buffer';
        
        % Adjust angles for imaging
        adjusted_angles = adjust_angles(angles, angle_sweep);
        
        % Generate position information for each sample along the scan line
        position_matrix = pol2cart(adjusted_angles, angle_count, intensity, sample_count);
        
        % Adjust the positions to fit the grid
        position_matrix_adjusted = adjust_position(position_matrix, mock_size, grid_resolution);
        
        % Plot individual points
        [grid1] = plot_to_grid(position_matrix_adjusted, angle_count, sample_count, intensity, grid1, grid_resolution);
        
        % Interpolate
        % UNDER-CONSTRUCTION Sector Averaging and Interpolation
        %[grid2, interpolation_grid] = interpolate(interpolation_grid, position_matrix_adjusted, angle_count, sample_count, intensity, grid2, grid_width, grid_height, sector_span);
        %[grid3, interpolation_grid_nonideal] = interpolate_nonideal(interpolation_grid_nonideal, position_matrix_adjusted, angle_count, sample_count, intensity, grid3, grid_width, grid_height, sector_span);
        
        % Contrast
        
        % Write images to gif
        f = figure();
        image(grid1);
%         f = figure('Visible', 'off', 'rend','painters','pos',[10 10 1100 400]);
%         
%         subplot(1,2,1);
%         image(grid1);
%         title(['(1) Pre-Interpolation']);
%         
%         subplot(1,2,2);
%         image(grid2);
%         title(['(2) Post-Interpolation']);
        
%         subplot(1,3,1);
%         image(grid1);
%         title(['(1) Pre-Interpolation']);
%         
%         subplot(1,3,2);
%         image(grid2);
%         title(['(2) Post-Interpolation - Ideal']);
%         
%         subplot(1,3,3);
%         image(grid3);
%         title(['(2) Post-Interpolation - Nonideal']);
        
        scan_file = 'modelScan.gif';
        % Capture the plot as an image
        frame = getframe(f);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        
        if count == sector_span
            disp(['Writing frame 1']);
            imwrite(imind,cm,scan_file,'gif', 'Loopcount',inf, 'DelayTime', 1);
        else
            disp(['Writing frame ' num2str(count-(sector_span-1))]);
            imwrite(imind,cm,scan_file,'gif','WriteMode','append', 'DelayTime', 1);
            
        end
        
        % Adjust Buffer
        angle_buffer(1) = [];
        intensity_buffer(:,1) = [];

        % Continue "Sector Averaging" until there are no more lines to read
        if (count + 1) > mock_size
            EOF = 1;
        end
    end
    
    count = count + 1;
end

disp('Done!');

% f1 = figure(1);
% 
% % Generate mock data
% mock_size = 25;
% angle_sweep = 45;
% [angle_count, sample_count, angles, intensity] = generate_data(mock_size, angle_sweep, 'boundary', 'gradient', 'ideal');
% % Sort data
% angles = angles';
% intensity = intensity';
% [angles, intensity] = sort_data(angles, intensity);
% 
% 
% % Adjust angles for imaging
% adjusted_angles = adjust_angles(angles, angle_sweep);
% 
% % Generate position information for each sample along the scan line
% position_matrix = pol2cart(adjusted_angles, angle_count, intensity, sample_count);
% 
% % Initalie a blank grid
% grid_resolution = 10;
% [grid, grid_width, grid_height] = init_grid(angle_count, sample_count, grid_resolution);
% 
% % Adjust the positions to fit the grid
% position_matrix_adjusted = adjust_position(position_matrix, angle_count, grid_resolution);
% 
% % Plot data points onto a grid
% grid1 = grid;
% [grid1] = plot_to_grid(position_matrix_adjusted, angle_count, sample_count, intensity, grid, grid_resolution);
% 
% image(grid1);
% title(['Boundary - Random - Ideal']);
% clear