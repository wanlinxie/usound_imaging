PLOT_RANGE = 1:1000; % Range of samples to plot

%% Import Data from Files
path = './data/';

%% MECHSCAN1_24
% Contains raw signal data -- be sure to extract envelope
TX_PULSE = 0.8;
MAX_SCAN_LEN = 340;
filename1 = 'mechscan1_24.h5';
dset1 = sprintf('/Waveforms/channel2\n/channel2\n Data');
signal = h5read([path filename1], dset1);
signal = abs(signal);
[envelopeUpper, envelopeLower] = envelope(signal);
signal_envelope = envelopeUpper;
envelope1 = signal_envelope;

% %% SHRUNKENGELATIN
% % Contains enveloped data -- no need to extract envelope
% TX_PULE = 1;
% MAX_SCAN_LEN = 18;
% 
% filename1 = 'shrunkengelatin.h5';
% dset1 = sprintf('/Waveforms/Channel 2/Channel 2 Data');
% signal = h5read([path filename1], dset1);
% signal = abs(signal);
% signal_envelope = signal;
% envelope1 = signal_envelope;

%% Collect Transmission Peak Information
% Find peaks and locations of peaks
% TODO: replace/rewrite findpeaks() from scratch

[pks, locs] = findpeaks(signal_envelope);

% pks_Tx and locs_Tx contain the value and location of Tx peaks
pks_Tx = pks;
pks_Tx(pks < TX_PULSE) = [];
locs_Tx = locs;
locs_Tx(pks < TX_PULSE) = [];

%% Seperate [envelope] into segments
% Iterate over each peak
intensity = []; % matrix of intensities
lens = []; % length of each scan line

% Iterate over each transmission peak
for i = 1:length(locs_Tx)-1
   pk_loc = locs_Tx(i);
   
   % A scan is considered any data right after the transmission pulse and
   % right before the next transmission pulse
   range = (pk_loc+1):(locs_Tx(i+1)-1);
   lens = [lens length(range)];
   if(length(range) > 1)
       line = signal_envelope(range);
       line(MAX_SCAN_LEN) = 0;

       % Add scan data to intensity matrix
       if(~isempty(line))
           intensity = [intensity line];
       end
   end
end

temp_intensity = intensity;
temp_intensity(intensity > TX_PULSE) = 0;

f1 = figure(1);
plot(signal_envelope(PLOT_RANGE));
title(['Envelope']);

f2 = figure(2);
image(temp_intensity, 'CDataMapping', 'scaled');
title(['Intensity - Including Partial Scan Lines']);

% Remove empty columns
temp_intensity = intensity;
intensity = [];
length_threshold = mean(lens);
for i = 1:size(temp_intensity, 2)
   if(size(nonzeros(temp_intensity(:,i)), 1) >= length_threshold)
      intensity = [intensity temp_intensity(:,i)];
   end
end
intensity(intensity > TX_PULSE) = 0;

f3 = figure(3);
image(intensity, 'CDataMapping', 'scaled');
title(['Intensity - After Removing Partial Scan Lines']);