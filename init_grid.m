% Miguel Angel Gutierrez
% mag2293@columbia.edu
% Creative Machines Lab @ Columbia University
%
% June 14, 2017
%
% INPUT: integer - angle_count; integer - sample_count; integer -
% resolution
% OUTPUT: 2D array - grid; integer - grid_width; integer - grid_height
%
% init_grid takes the number of angles and samples taken at each angle,
% along with a resolution coefficient and produces a blank grid.

function [grid, grid_width, grid_height] = init_grid(angle_count, sample_count, resolution)

    % Initialize blank grid
    grid_width = angle_count .* resolution;
    grid_height = sample_count .* resolution;
    grid = zeros(grid_height, grid_width);

end