% Miguel Angel Gutierrez
% mag2293@columbia.edu
% Creative Machines Lab @ Columbia University
%
% June 14, 2017
%
% INPUT: 2D array - grid; 2D array - position_matrix; integer -
% angle_count; integer - sample_count; integer - white_value
% OUTPUT: 2D array - new_grid
%
% draw_bounds creates an outline around the plotted data, to differentiate
% it from the background. The outline is of color [white_value].

function [new_grid] = draw_bounds(grid, position_matrix, angle_count, sample_count, white_value)
    new_grid = grid;
    right_boundary = position_matrix(:,1,:);
    left_boundary = position_matrix(:,angle_count,:);
    upper_boundary = position_matrix(1,:,:);
    lower_boundary = position_matrix(sample_count,:,:);
    
    intensity = ones(sample_count,1) .* white_value;
    new_grid = draw(right_boundary, 1, sample_count, intensity, new_grid);
    new_grid = draw(left_boundary, 1, sample_count, intensity, new_grid);
    
    intensity = ones(1, angle_count) .* white_value;
    new_grid = draw(upper_boundary, angle_count, 1, intensity, new_grid);
    new_grid = draw(lower_boundary, angle_count, 1, intensity, new_grid);
    
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