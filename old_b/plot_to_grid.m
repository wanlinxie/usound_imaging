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

function [grid, plot_grid] = plot_to_grid(plot_grid, position_matrix, angle_count, sample_count, intensity, grid)
    %% Map position_matrix information over the blank grid
    % Iterate through columns of the position/intensity matrices

    for i = 1:angle_count
        % Iterate through row of data
        for j = 1:sample_count
            y = position_matrix(j,i,2);
            x = position_matrix(j,i,1);
            % Do not plot undefined values
            if(intensity(j, i) == intmax)
                grid(y,x) = 0;
            else
                plot_grid{y,x} = [plot_grid{y,x} intensity(j,i)];
                grid(y,x) = sum(plot_grid{y,x}) ./ length(plot_grid{y,x});
            end
        end
    end

end