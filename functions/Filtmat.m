function fdata = Filtmat(dt, cutoff, forder, data)

%  filter data forward and reverse using butterworth filter
%  on columns of matrix elements
%  [fdata] = filtmat(dt, cutoff, forder, data)
%
%  John H. Challis, The Penn. State University
%  April 24, 1997
%
%  inputs
%  ------
%  dt     - interval between samples
%  cutoff - required cut-off frequency
%  forder - order of filter
%  data   - the matrix containing the data
%
%  output
%  ------
%  fdata - the filtered input data
%
%  calls
%  -----
%  paddon  - pads data matrix prior to filtering to remove end point problems
%  paddoff - unpads data matrix after filtering
%

%  adjust cut-off to allow for double pass
%

cutoff = cutoff / (sqrt(2) - 1)^(0.5 / forder);

%  compute coefficients
%
[b, a] = butter(forder, 2 * cutoff * dt);

%  padd data to allow for end point problems
%
[data, nadd] = Paddon(data);

%  how much data
%
[m, n] = size(data);

%  filter the data
%
fdata = zeros(m, n);
for i = 1:n
   fdata(:,i) = filtfilt(b, a, data(:, i));
end

%  unpad data
%
fdata = Paddoff(fdata, nadd);
end

%%% the end %%%