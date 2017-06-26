% Miguel Angel Gutierrez
% mag2293@columbia.edu
% Creative Machines Lab @ Columbia University
%
% June 14, 2017
%
% INPUT: 1D array - angles
% OUTPUT: 1D array - adjusted_angles
%
% adjust_angles takes in a sorted array of angles [angles], and and centers the
% spread of the angles.
% For example, if [angles] contains angles raning from 0-90 degrees,
% adjust_angles will rotate the spread so that the 45 degree line will be
% positioned at 90 degrees.

function [adjusted_angles] = adjust_angles(angles, sweep_angle)

    % Adjust angles to center image
    center_angle = (0.5 * sweep_angle);
    angle_diff = 90 - center_angle;
    adjusted_angles = angles + angle_diff;
end