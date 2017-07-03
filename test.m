% % Generate mock data
% mock_size = 5;
% angle_sweep = 45;
% [angle_count, sample_count, angles_file, intensity_file] = generate_data(mock_size, angle_sweep, 'boundary', 'gradient', 'ideal');

import_scope

angle_sweep = 30;
angle_count = size(intensity, 2);
sample_count = MAX_SCAN_LEN;
angles = linspace(0, angle_sweep, angle_count);

% Sort data
angles = angles';
intensity = intensity';
[angles, intensity] = sort_data(angles, intensity);

% Adjust angles for imaging
disp('Adjusting Angles');
adjusted_angles = adjust_angles(angles, angle_sweep);

% Generate position information for each sample along the scan line
disp('Generating Positions');
position_matrix = pol2cart(adjusted_angles, angle_count, sample_count);

% Initalie a blank grid
grid_resolution = 1;
grid_width = MAX_SCAN_LEN; %ceil(max(max(abs(position_matrix(:,:,1)))));
grid_height = MAX_SCAN_LEN;
[grid, grid_width, grid_height] = init_grid(grid_width, grid_height, grid_resolution);

% Adjust the positions to fit the grid
disp('Adjusting Positions for Grid');
position_matrix_adjusted = adjust_position(position_matrix, grid_width, grid_resolution);

% Plot data points onto a grid
disp('Plotting Points to Grid');
grid1 = grid;
plot_grid = cell(grid_height, grid_width);
[grid1, plot_grid] = plot_to_grid(plot_grid, position_matrix_adjusted, angle_count, sample_count, intensity, grid);

horiz_width = ceil(max(max(abs(position_matrix(:,:,1)))));
horiz_range = (((grid_width/2) - horiz_width):((grid_width/2) + horiz_width));
temp = grid1(:,horiz_range);

f1 = figure(1);
image(temp,'CDataMapping','scaled');
axis image;
title('(1) SCOPE - Pre Interpolation');

%%

% UNDER-CONSTRUCTION Sector Averaging and Interpolation
disp('Interpolating...');
interpolation_grid = cell(grid_height, grid_width, 2);
% Maximum Value = (1/2) * angle_count
sector_span = 3;
grid2 = grid;
[grid2, interpolation_grid] = interpolate(interpolation_grid, position_matrix_adjusted, angle_count, sample_count, intensity, grid2, grid_width, grid_height, sector_span);

temp = grid2(:,horiz_range);

f2 = figure(2);
image(temp,'CDataMapping','scaled');
title('(2) SCOPE - Post-Interpolation');
axis image;

% Smooth image boundaries
disp('Smoothing Boundaries');
grid3 = grid2;
grid3 = boundary_smoothing(adjusted_angles, angle_count, sample_count, grid3, grid_width, grid_height, grid_resolution);

temp = grid3(:,horiz_range);

f3 = figure(3);
image(temp, 'CDataMapping','scaled');
title('(3) SCOPE - Smoothing Boundaries');
axis image;

% Control image contast and color levels
disp('Color Levels');
intensity_min = 0;
intensity_max = max(max(intensity));
black_threshold = 0; % 0
white_threshold = 255; % 255
level_count = 255;

grid4 = grid3;
grid4 = draw_bounds(grid4, position_matrix_adjusted, angle_count, sample_count, white_threshold);
grid4 = contrast(grid4, intensity_min, intensity_max, black_threshold, white_threshold, level_count);

temp = grid4(:,horiz_range);

f4 = figure(4);
I = imshow(temp, [0 255]);
title('(4) SCOPE - Grayscale Image'); 

f5 = figure(5);
medfilter = medfilt2(grid3);
temp = medfilter(:,horiz_range);
image(temp, 'CDataMapping','scaled');
title('SCOPE - Median Filterd');
axis image;

f6 = figure(6);
kernel = (1/16) .* [ 1 2 1; 2 4 2; 1 2 1];
gaussian = conv2(grid3, kernel);
temp = gaussian(:,horiz_range);
image(temp, 'CDataMapping','scaled');
title('SCOPE - Gaussian Filterd');
axis image;


%% TO DO
% - Research other interpolation methods other than weighed-average
% - Start experimenting with performance/optimization?
