clear, close all, clc
set(0,'DefaultFigureWindowStyle','normal'); 
%% ====================================================================
lambdac=300/2000;                   % wavelength for a 2 GHz carrier
NofWavelengths=10;   
SamplesperWavelength=4;
lengthwindow=NofWavelengths*SamplesperWavelength;
windowinmeters=NofWavelengths*lambdac;

s.series12 = load_02_jan_22();

distanceaxis =  s.series12(:,1);  % distance axis in m (sampled wavelength/4
s.P =           s.series12(:,2);      % P in dBm
s.p = 10.^(s.P/10);         % now p is in mW
s.p = s.p/1000;             % now p is in W
s.v = sqrt(2*50*s.p);     % compute the voltage
s.V = 20*log10(s.v*1e6);          % now V is in dBV
%% Low-pass filtering ===================================================
[averagingwindow,s.vfiltered] = low_pass_filtering(lengthwindow,s);
s.VFILTERED = 20*log10(s.vfiltered*1e6);
%% ======================================================================
s.vfast=s.v./s.vfiltered;    % remove slow variations and normalize
s.VFAST = 20*log10(s.vfast);
%% STATISTICAL ANALYSIS ==================================================
M.FV =  mean(   s.vfast(length(averagingwindow):end));
SD.FV = std(    s.vfast(length(averagingwindow):end));
M.SV =  mean(   s.VFILTERED(length(averagingwindow):end));
SD.SV = std(    s.VFILTERED(length(averagingwindow):end));

sigma=M.FV/1.25;
[CDF.x.fast,    CDF.y.fast]=    fCDF(s.vfast(length(averagingwindow):end));
[CDF.x.slow,    CDF.y.slow]=    fCDF(s.VFILTERED(length(averagingwindow):end));
[CDF.x.overall, CDF.y.overall]= fCDF(s.V(length(averagingwindow):end));

[CDF.y.Theoretical.fast]=RayleighCDF(sigma,     CDF.x.fast);
[CDF.y.Theoretical.slow]=GaussianCDF(M.SV,SD.SV,CDF.x.slow);

%%
[f1, f2, f3] = plotting(s, CDF, distanceaxis);
autoArrangeFigures(1,3,1);
% close all;