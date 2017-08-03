% Miguel Angel Gutierrez
% mag2293@columbia.edu
% Creative Machines Lab @ Columbia University
%
% June 14, 2017
%
% INPUT: 1D matrix - angles; 2D matrix - intensity
% OUTPUT: 1D matrix - sorted_angles; 2D matrix - sorted_intensity
%
% sort_data sorts [angles] in ascending order, along with the
% associated columns in [intensity]

function [sorted_angles, sorted_intensity] = sort_data(angles, intensity)
    if(length(angles) == size(intensity, 1))
       temp = [angles intensity];
       temp = sortrows(temp);
       sorted_angles = temp(:,1)';
       temp(:,1) = [];
       sorted_intensity = temp';
    else
        disp('ERROR in sorted_angles');
        disp('Check dimensions?');
    end