TX_PULSE = 0.6;
MAX_SCAN_LEN = 18;
PLOT_RANGE = 1:100;

%% Import Data from Files
path = '../data/';

%filename1 = 'mechscan1_24.h5';
%dset1 = sprintf('/Waveforms/channel2\n/channel2\n Data');

filename1 = 'shrunkengelatin.h5';
dset1 = sprintf('/Waveforms/Channel 2/Channel 2 Data');

signal = h5read([path filename1], dset1);
signal = abs(signal)-0.2;

%% Extract Envelope
%envelopeUpper = signal;
%[envelopeUpper, envelopeLower] = envelope(signal);
%envelope = h5read([path filename2], dset2);

envelopeSig = signal;

%% Collect Transmission Peak Information
% Find peaks and locations of peaks
% TODO: replace/rewrite findpeaks()
% ONLY NEED THE FIRST TX PEAK for this

[pks, locs] = findpeaks(double(envelopeSig));

%pks_Tx and locs_Tx contain the value and location of the transmission
%signals
pks_Tx = pks;
pks_Tx(pks < TX_PULSE) = [];
locs_Tx = locs;
locs_Tx(pks < TX_PULSE) = [];

%% Zero-out the data scale
% % From the beginnning up to the first Tx
% range = (1:locs_Tx(1));
% avg = mean(envelopeSig(range));
% first_peak = find((pks >= TX_PULSE), 1) - 1;
% range_pks = (1:first_peak);
% avg_threshold = mean(pks(range_pks)) - avg;

envelope1 = envelopeSig;
% Zero-out and remove data below the threshold
% envelope1 = envelope1 - avg;
% envelope1(envelope1 <= avg_threshold) = 0;

%% Seperate [envelope] into segments
% Calculate Peaks
% TOFO: replace/reqrite findpeaks()

%[pks, locs] = findpeaks(envelope1);

envelope2 = envelope1;

% Iterate over each peak
intensity = [];
lens = [];
end_idx = 1;

% Iterate over each transmission peak
for i = 1:length(locs_Tx)-1
    
   pk_loc = locs_Tx(i);
   
   % Find the beginning of the peak
   %temp = envelope1(1:pk_loc);
   %start_idx = find((temp == 0), 1, 'last');
   
   % A scan is considered any data right after the transmission pulse and
   % right before the next transmission pulse
   range = (pk_loc+1):(locs_Tx(i+1)-1);
   if(length(range) > 1)
       line = envelope1(range);
       line(MAX_SCAN_LEN) = 0;

       %temp = envelope1(pk_loc:end);
       %end_idx = find((temp == 0), 1) + pk_loc + 15;

       % [envelope2] is used to plot the signal after the transmission pulses
       % are removed
       envelope2(pk_loc:(pk_loc+1)) = 0;

       % Add scan data to intensity matrix
       if(~isempty(line))
           %length(line)
           lens = [lens length(line)];
%            disp('++++++++++')
%            size(intensity)
%            size(line)
%            range
%            line
           intensity = [intensity line];
       end
   end
end

%intensity(intensity > TX_PULSE) = 0;

f1 = figure(1);
subplot(1,3,1)
plot(envelopeSig(PLOT_RANGE), 'o');
title(['Envelope']);

subplot(1,3,2)
plot(envelope1(PLOT_RANGE));
title(['Zeroed Out']);

subplot(1,3,3)
plot(envelope2(PLOT_RANGE));
title(['Tx Removed']);

f2 = figure(2);
image(intensity, 'CDataMapping', 'scaled');
title(['Intensity']);