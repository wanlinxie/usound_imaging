# usound_imaging
For example plots, see /plots/

## test.m ##
test.m and its associated suite of functions generate 2-D plots of ultrasound data.

The functions used in test.m were developed at the beginning of Summer 2017, and were 
a first attempt at creating an imaging workflow. Once we were able to work with ultrasound 
data recorded by the oscilloscope, these functions were quickly found to be slow and 
inefficient. In particular, the 2-D interpolation scheme in interpolate.m proved to be 
inefficient in dealing the large amounts of data points we were plotting. Given the 
resolution of our scans, it was questioned if 2-D interpolation was even necessary.

## import_scope.m ##
import_scope.m imports a stream of data recorded onto an h5 file from the oscilloscope 
and processes it into a 2-D matrix that can later be imaged.

Due to way we currently split the data stream, portions of the transmit signal can 
appear as their own individual scan lines. import_scope removes these artifiacts.
This processing should become unnecessary once we are able to recieve data directly 
from the STM32.

## Data Format ##

The format for both mock and oscilloscope data consists of a 2-D matrix where columns 
represent scan lines at different angles, and a 1-D array that contains the angles that
correspond to columns in the 2-D matrix.

				+-------------------------------+
				| 0 | 5 | 10 | 15 | 20 | 25 | 30|  <-- 1-D angle array
				+-------------------------------+

				+-------------------------------+
				|   |   |    |    |    |    |   |  <-- 2-D matrix of intensities
				+-------------------------------+
				|   |   |    |    |    |    |   |
				+-------------------------------+
				|   |   |    |    |    |    |   |
				+-------------------------------+
				|   |   |    |    |    |    |   |
				+-------------------------------+
				
Note: Currently, since we have not yet recorded data from the motor encoder, we guess 
and generate a linearrly spaced array of angles in order to image data.

## Important Variables ##

- intensity: [2D matrix] Signal amplitudes. Columns represent different angles. 
- angles: [1D array] 
- adjusted-angles: [1D array] Angles rotated and centered around 270 degrees.
- grid_resolution: [int] Multiper that expands the grid and adds space between data 
  points to be interpolated.
- TX_PULSE: [float] Threshold for identifying a signal peak as a transmit peak
- MAX_SCAN_LEN: [int] Defines the maximum length of a scan line (in # of samples)
- angle_sweep: [int] Defines the width of the image
- angle_count: [int]
- sample_count: [int] 