clear;
clc;
[file,path]=uigetfile('*.*');
mp=strcat(path,file);
% Step 1: Read the MP3 file
[audioData, sampleRate] = audioread(mp);

% Convert to mono if stereo
if size(audioData, 2) == 2
    audioData = mean(audioData, 2);
end

[fy,MSE,PSNR] = filter_audio(audioData,sampleRate,0,3);

error=audioData-fy;
MSEg=mean(error.^2,'all');