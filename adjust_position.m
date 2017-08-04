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

function position_matrix_adjusted = adjust_position(position_matrix, grid_width, grid_resolution)
    % Adjust points relative to the grid's resolution
    position_matrix_adjusted = round(position_matrix .* grid_resolution);
    % Center position_matrix values (no negative positions in grid)
    position_matrix_adjusted(:,:,1) = round(position_matrix_adjusted(:,:,1) + grid_width/2);
end