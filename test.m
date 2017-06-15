% Generate mock data
mock_size = 10;
angle_sweep = 45;
[angle_count, sample_count, angles, intensity] = generate_data(mock_size, angle_sweep, 'random');

% Sort data
[angles, intensity] = sort_data(angles, intensity);

% Adjust angles for imaging
adjusted_angles = adjust_angles(angles);

% Generate position information for each sample along the scan line
position_matrix = pol2cart(adjusted_angles, angle_count, intensity, sample_count);

% Initalie a blank grid
grid_resolution = 10;
[grid, grid_width, grid_height] = init_grid(angle_count, sample_count, grid_resolution);

% Adjust the positions to fit the grid
position_matrix_adjusted = adjust_position(position_matrix, angle_count, grid_resolution);

% Plot data points onto a grid
grid1 = grid;
[grid1] = plot_to_grid(position_matrix_adjusted, angle_count, sample_count, intensity, grid, grid_resolution);

f1 = figure(1);
image(grid1);
title(['(1) Pre-Interpolation']);

% UNDER-CONSTRUCTION Sector Averaging and Interpolation
% Maximum Value = (1/2) * angle_count
sector_span = 5;
grid2 = grid;
grid2 = interpolate(position_matrix_adjusted, angle_count, sample_count, intensity, grid2, grid_width, grid_height, sector_span);

f2 = figure(2);
image(grid2);
title(['(2) Post-Interpolation']);

% Smooth image boundaries
grid3 = grid2;
grid3 = boundary_smoothing(adjusted_angles, angle_count, sample_count, grid3, grid_width, grid_height, grid_resolution);

f3 = figure(3);
image(grid3);
title(['(3) Smoothing Boundaries']);

% Control image contast and color levels
intensity_min = 0;
intensity_max = 100;
black_threshold = 0; % 0
white_threshold = 255; % 255
level_count = 8;
grid4 = grid3;
grid4 = contrast(grid4, intensity_min, intensity_max, black_threshold, white_threshold, level_count);

f4 = figure(4);
I = imshow(grid4, [0 255]);
truesize(f4, [342 434]);
title(['Grayscale Image']); 


%% TO DO
% - Research other interpolation methods other than weighed-average
% - Start experimenting with performance/optimization?
