% Miguel Angel Gutierrez
% mag2293@columbia.edu
% Creative Machines Lab @ Columbia University
%
% June 14, 2017
%
% INPUT: 2D matrix - grid; integer_intensity_min; integer - intensity_max;
% integer - black_threshold; integer - white_threshold; integer -
% level_count
% OUTPUT: 2D matrix - grid;
%
% contrast() allows the user to adjust the b/w thresholds and color levels
% for the image contained in [grid]

function [grid] = contrast(grid, intensity_min, intensity_max, black_threshold, white_threshold, level_count)
%% Color Levels and Contrast Control
color_levels = linspace(black_threshold, white_threshold, level_count);
grid = (grid ./ intensity_max ) .* 255;
grid(grid < black_threshold) = 0;

prevAvg = 0;
for i = 1:(length(color_levels) - 1)
    avg = (color_levels(i) + color_levels(i+1)) / 2;
    grid((grid > prevAvg) & (grid < avg)) = color_levels(i);
    prevAvg = avg;
    %grid((grid > color_levels(i)) & (grid < color_levels(i+1))) = color_levels(i); 
end
grid(grid > white_threshold) = 255;