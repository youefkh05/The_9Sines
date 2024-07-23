function [fy,MSE,PSNR] = filter_audio(oy,f,show,mode)
%FILTER_AUDIO Summary of this function goes here
%   Detailed explanation goes here
if mode==1
    [fy]=wavelet_filter(oy,show);
elseif mode==2
    [fy]=FIR_filter(oy,f,show);
elseif mode==3
    [fy]=IIR_filter(oy,f,show);
end

%-----------------------Experiment parameters(SNR, PSNR, MSE)--------------------------------------

%SNR:
% Calculate the power of the clean signal
cleanPower = mean(oy.^2);

% Calculate the power of the residual noise
noiseSignal = oy - fy;
noisePower = mean(noiseSignal.^2);

% Calculate the SNR in decibels
SNR = 10 * log10(cleanPower / noisePower);

% Calculate MSE (Mean Squared Error)
error=oy-fy;
MSE=mean(error.^2,'all');

% Calculate PSNR (Peak Signal-to-Noise Ratio)
maxAmplitude = max(abs(oy));
PSNR = 10 * log10((maxAmplitude.^2) / MSE);

% Display the results
fprintf('MSE: %f\n', MSE);
fprintf('PSNR: %f dB\n', PSNR);


end




