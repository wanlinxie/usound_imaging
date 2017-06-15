% Miguel Angel Gutierrez
% mag2293@columbia.edu
% Creative Machines Lab @ Columbia University
%
% June 14, 2017
%
% INPUT: 2D matrix - position_matrix; integer angle_count; integer -
% sample_count; 2D matrix - intensity; 2D matrix - grid; integer -
% grid_resolution
% OUTPUT: 2D matrx - grid; 2D matrix - position_matrix_adjusted
%
% plot_to_grid plots the intensities in [intensity] onto [grid], using the
% corresponding coordinates found in [posiiton_matrix]. plot_to_grid
% returns the grid with intensities plotted, as well as a 2D matrix -
% [position_matrix_adjusted], which holds the coordinates to the
% intensities after being plotted on [grid].

function [grid] = plot_to_grid(position_matrix, angle_count, sample_count, intensity, grid, grid_resolution)


    
    %DEBUG
    

    %% Map position_matrix information over the blank grid
    % Iterate through columns of the position/intensity matrices
    for i = 1:angle_count
        % Iterate through row of data
        for j = 1:sample_count
            
%             % Extract coordinates from [position_matrix]
%             current_position = [0, 0];
%             current_position(1) = position_matrix(j,i,1);
%             current_position(2) = position_matrix(j,i,2);
% 
%             % Adjust the coordinates by multiplying by [grid_resolution]
%             current_position_adjusted = current_position .* grid_resolution;
%             current_position_adjusted = round(current_position_adjusted);
%             
%             % Store the adjusted coordinates in [position_matrix_adjusted]
%             position_matrix_adjusted(j,i,1) = current_position_adjusted(1);
%             position_matrix_adjusted(j,i,2) = current_position_adjusted(2);
%             
%             % Plot the intensity value in [grid]
%             grid(current_position_adjusted(2), current_position_adjusted(1)) = intensity(j,i);

            grid(position_matrix(j,i,2), position_matrix(j,i,1)) = intensity(j,i);
            
            
        end
    end

end