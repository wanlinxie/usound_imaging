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

function [grid] = draw_bounds(grid, position_matrix, angle_count, sample_count, white)
    right_boundary = position_matrix(:,1,:);
    left_boundary = position_matrix(:,angle_count,:);
    upper_boundary = position_matrix(1,:,:);
    lower_boundary = position_matrix(sample_count,:,:);
    
    intensity = ones(sample_count,1) .* white;
    grid = draw(right_boundary, 1, sample_count, intensity, grid);
    grid = draw(left_boundary, 1, sample_count, intensity, grid);
    
    intensity = ones(1, angle_count) .* white;
    grid = draw(upper_boundary, angle_count, 1, intensity, grid);
    grid = draw(lower_boundary, angle_count, 1, intensity, grid);
    
end

function [grid] = draw(position_matrix, angle_count, sample_count, intensity, grid)
    for i = 1:angle_count
        % Iterate through row of data
        for j = 1:sample_count
            y = position_matrix(j,i,2);
            x = position_matrix(j,i,1);
            grid(y,x) = intensity(j,i);
        end
    end
end