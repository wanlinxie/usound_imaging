% Miguel Angel Gutierrez
% mag2293@columbia.edu
% Creative Machines Lab @ Columbia University
%
% June 14, 2017
%
% INPUT: 2D matrix - position_matrix; integer angle_count; integer -
% sample_count; 2D matrix - intensity; 2D matrix - grid;
% integer - sector_span 
% OUTPUT: 2D matrx - grid
%
% interpolate() fills in the blank spaces between data from [position_matrix]
% and [intensity] that has been plotted on [grid]. Each interpolated data
% value is the weighted average of the data values around it. The weights
% are calculated as the inverse of the distance between the pixel and the
% data point.

function [grid, interpolation_grid] = interpolate(interpolation_grid, position_matrix, angle_count, sample_count, intensity, grid, sector_span)
% interpolation_grid is a cell array that corresponds to the pixels
% represented in grid. Each ordered pair (r,c) in interpolation grid
% contains two arrays: 1) values, 2) weights used to calculate the value of
% the pixel

% Iterate over the adjusted position matrix
for i = 1:angle_count
    for j = 2:(sample_count - 1)
        
        p_x = position_matrix(j,i,1);
        p_y = position_matrix(j,i,2);

        % Create boundary points for interpolation
        if (i-sector_span) <= 0
            x_start = position_matrix(j,sector_span,1);
            x_end = position_matrix(j+1,1,1); % i -> 1
        elseif (i+sector_span) > (angle_count)
            x_start = position_matrix(j+1,angle_count,1);
            x_end = position_matrix(j,i-sector_span,1);
        else
            x_start = position_matrix(j, i+sector_span,1);
            x_end = position_matrix(j,i-sector_span,1);
        end
        y_start = position_matrix(j-1,i,2);
        y_end = position_matrix(j+1,i,2);
        
        if( (y_end-y_start) > 2 && (x_end-x_start) > 2 )
            % Iterate within boundaries
            for y  = y_start:y_end
                for x = x_start:x_end
                    % Add this value to the pixel's value array
                    interpolation_grid{y,x,1} = [interpolation_grid{y,x,1} intensity(j, i)];

                    % Calculate distance between this pixel and the pixel in
                    % position_matrix
                    distance = sqrt( (x - p_x)^2 + (y - p_y)^2 );

                    % The inverse of the distance corresponds to the value's
                    % weight

                    % DEBUGGING - should 'cut off' values have a weight?
                    if intensity(j, i) == intmax
                        weight = 0;
                    elseif distance == 0
                        weight = 2;
                    else
                        weight = 1/distance;
                    end

                    interpolation_grid{y,x,2} = [interpolation_grid{y,x,2} weight];

                    % Calculate the weighted average
                    weighted_average = sum(interpolation_grid{y,x,1} .* interpolation_grid{y,x,2}) ./ sum(interpolation_grid{y,x,2});

                    % Assign the weighted average to the pixel
                    grid(y,x) = weighted_average;
                end
            end
            
        else
            grid(p_y,p_x) = intensity(j, i);
        end
    end
end