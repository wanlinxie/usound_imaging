% Miguel Angel Gutierrez
% mag2293@columbia.edu
% Creative Machines Lab @ Columbia University
%
% June 14, 2017
%
% INPUT: 1D array - angles; integer - angle_count; 2D array - intensity;
% integer - sample_count
% OUTPUT: 2D array - position_matrix
%
% pol2cart takes a 1D array of angles and a corresponding 2D matrix of
% intensities (polar information) and produces a 3D matrix [position_matrix] (cartesian information). The first two
% indices correspond to the indices of [intensity]. The third index
% contains the X and Y corrdinates at indices 1 and 2 respectively.
%
% EXAMPLE: position_matrix(5,3,2) contains the Y-coordinate for the
% intensity value in intensity(5,3)

function [position_matrix] = pol2cart(angles, angle_count, sample_count)
    % [X, Y]
    position_matrix = zeros(sample_count, angle_count, 2);

    % i = column #; j = row #
    % Iterate through columns
    for i = 1:angle_count
        % Iterate through rows
        for j = 1:sample_count
            % Caculate catesian position information
            position_matrix(j,i,1) = j * cosd(angles(i));
            position_matrix(j,i,2) = j * sind(angles(i));
        end
    end
end