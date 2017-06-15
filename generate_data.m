% Miguel Angel Gutierrez
% mag2293@columbia.edu
% Creative Machines Lab @ Columbia University
%
% June 14, 2017
%
% USAGE: generate_data(integer mock_size, ['random'|'gradient']
% INPUT: integer - mock_size; integer - angle_sweep; arguments - 'random' or 'radient'
% OUTPUT: integer - angle_count; integer - sample_count; array - angles; 2D
% - matrix intensity
%
% generate_data generates an array of linearly spaced angles [angles] ranging from 0
% to [angle_sweep], and a 2D matrix of data values [intensity], where each column
% corresponds to an angle in [angles]. Rows in [intensity] are treated as
% samples taken at different depths.

function [angle_count, sample_count, angles, intensity] = generate_data(mock_size, angle_sweep, varargin)
    if (strcmp(varargin{1}, 'random'))
        % Generate a matrix of random values
        intensity = rand(mock_size) .* 100;
    else (strcmp(varargin{1}, 'gradient'))
        % Generate a matrix of linearlly increasing values
        intensity = linspace(0, 100, mock_size)';
        intensity = repmat(intensity, 1, mock_size);
    end
    
    % Generate an array of linearlly spaced angles
    angles = linspace(0, angle_sweep, mock_size);
    
    % Take the dimensions of (intensity)
    sample_count = size(intensity, 1);
    angle_count = size(intensity, 2);
end