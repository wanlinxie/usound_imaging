% Miguel Angel Gutierrez
% mag2293@columbia.edu
% Creative Machines Lab @ Columbia University
%
% June 14, 2017
%
% INPUT: 2D matrix - position_matrix; integer - angle_count; integer -
% grid_resolution
% OUTPUT: 2D matrix - position_matrix_adjusted
%
% adjust_position returns a new position matrix [position_matrix_adjusted]
% that fits within the grid used to display the positions

function position_matrix_adjusted = adjust_position(position_matrix, angle_count, grid_resolution)
    position_matrix_adjusted = position_matrix;
    
    % Center position_matrix values (no negative positions in grid)
    position_matrix_adjusted(:,:,1) = position_matrix(:,:,1) + (angle_count/2);
    
    % Adjust points relative to the grid's resolution
    position_matrix_adjusted = round(position_matrix_adjusted .* grid_resolution);
end