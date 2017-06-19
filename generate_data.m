% Miguel Angel Gutierrez
% mag2293@columbia.edu
% Creative Machines Lab @ Columbia University
%
% June 14, 2017
%
% USAGE: generate_data(integer mock_size, ['random'|'gradient'|'object'],
% ['ideal'|'nonideal])
% INPUT: integer - mock_size; integer - angle_sweep; arguments - 'random' or 'radient'
% OUTPUT: integer - angle_count; integer - sample_count; array - angles; 2D
% - matrix intensity
%
% generate_data generates an array of linearly spaced angles [angles] ranging from 0
% to [angle_sweep], and a 2D matrix of data values [intensity], where each column
% corresponds to an angle in [angles]. Rows in [intensity] are treated as
% samples taken at different depths. The 'nonideal' argument generates a
% list of random angles within the range defined by [angle_sweep].
% Additionally, the columns in [intensity] are cut off at random points
% (with zeroes)

function [angle_count, sample_count, angles, intensity] = generate_data(mock_size, angle_sweep, varargin)

    if (strcmp(varargin{1}, 'random'))
        % Generate a matrix of random values
        intensity = rand(mock_size) .* 100;
    elseif (strcmp(varargin{1}, 'gradient'))
        % Generate a matrix of linearlly increasing values
        intensity = linspace(0, 100, mock_size)';
        intensity = repmat(intensity, 1, mock_size);
    elseif (strcmp(varargin{1}, 'object'))
        % Generate a matrix of linearlly increasing values
        intensity = 100*zeros(mock_size);
        % Generate a random 'block' of random size
        x = rand();
        y = x + rand() * ((1-x));
        a = round((x * mock_size));
        b = round((y * mock_size));
        intensity(a:b,a:b) = 80;
        intensity(:,:) = intensity(:,:) + 50*(rand(mock_size)-0.5);
    end
    
    if(strcmp(varargin{2}, 'ideal'))
        % Generate an array of linearlly spaced angles
        angles = linspace(0, angle_sweep, mock_size);
    elseif(strcmp(varargin{2}, 'nonideal'))
        % Generate an array of random angles (0-100)
        angles = round(rand(1, mock_size) * ((angle_sweep) + 1));
        % Cut-up the square matrix of intensity values
        % We want beams to be of different lengths
        lengths = floor(rand(1, mock_size) * (mock_size+1));
        for i = 1:mock_size
           if lengths(i) == 0
               intensity([1:mock_size], i) = 0; 
           else
               intensity([lengths(i):mock_size], i) = 0;
           end
        end
    end
    
    % Take the dimensions of (intensity)
    sample_count = size(intensity, 1);
    angle_count = size(intensity, 2);
end