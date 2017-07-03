TX_PULSE = 0.6;
MAX_SCAN_LEN = 320;
PLOT_RANGE = 12500:13000;

%% Import Data from Files
path = '../../Scans/';
filename1 = 'mechscan1_24.h5';
dset1 = sprintf('/Waveforms/channel2\n/channel2\n Data');
filename2 = 'mechscan1_25.h5';
dset2 = sprintf('/Waveforms/channel3\n/channel3\n Data');

signal = h5read([path filename1], dset1);

%% Apply Log Gain and Extract Envelope
%signal = mag2db(signal);
[envelopeUpper, envelopeLower] = envelope(signal);
envelopeSig = envelopeUpper;
%envelope = h5read([path filename2], dset2);

%% Zero-out the data scale
% Find peaks and locations of peaks
% TODO: replace/rewrite findpeaks()
% ONLY NEED THE FIRST TX PEAK for this
[pks, locs] = findpeaks(envelopeSig);
pks_Tx = pks;
pks_Tx(pks < TX_PULSE) = [];
locs_Tx = locs;
locs_Tx(pks < TX_PULSE) = [];

% From the beginnning up to the first Tx
range = (1:locs_Tx(1));
avg = mean(envelopeSig(range));
first_peak = find((pks >= TX_PULSE), 1) - 1;
range_pks = (1:first_peak);
avg_threshold = mean(pks(range_pks)) - avg;

envelope1 = envelopeSig;
% Zero-out and remove data below the threshold
envelope1 = envelope1 - avg;
envelope1(envelope1 <= avg_threshold) = 0;

%% Seperate [envelope] into segments
% Calculate Peaks
% TOFO: replace/reqrite findpeaks()
[pks, locs] = findpeaks(envelope1);
envelope2 = envelope1;

% Iterate over each peak
intensity = [];
lens = [];
end_idx = 1;
for pk_loc = locs_Tx'
   % Find the beginning of the peak
   temp = envelope1(1:pk_loc);
   start_idx = find((temp == 0), 1, 'last');
   
   line = envelope1(end_idx:start_idx);
   line(MAX_SCAN_LEN) = 0;
   
   temp = envelope1(pk_loc:end);
   end_idx = find((temp == 0), 1) + pk_loc;
   envelope2(start_idx:end_idx) = 0;
   
   
   % Add scan data to intensity matrix
   if(~isempty(line))
       lens = [lens length(line)];
       intensity = [intensity line];
   end
end

% f1 = figure();
% subplot(1,3,1)
% plot(envelopeSig(PLOT_RANGE));
% title(['Envelope']);
% 
% subplot(1,3,2)
% plot(envelope1(PLOT_RANGE));
% title(['Zeroed Out']);
% 
% subplot(1,3,3)
% plot(envelope2(PLOT_RANGE));
% title(['Tx Removed']);