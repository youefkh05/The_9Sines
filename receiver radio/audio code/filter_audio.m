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
mseValue = sum((oy - fy).^2) / length(oy);

% Calculate PSNR (Peak Signal-to-Noise Ratio)
maxAmplitude = max(abs(oy));
psnrValue = 10 * log10((maxAmplitude.^2) / mseValue);

% Display the results
fprintf('MSE: %f\n', mseValue(1));
fprintf('PSNR: %f dB\n', psnrValue);

MSE=mseValue(1);
PSNR=psnrValue;

end


%fprintf('Signal-to-Noise Ratio (SNR): %.2f dB\n',SNR);



