%% Assignment 4 
% Akhilesh Rao - N12365682, Ankit Dani - N12370523

clc;
clear all;
close all;

%% Parameters
win_size = 1024;                % Window size
hop_size = 512;                 % Hop size
min_freq = 86;                  % Minimum frequency
max_freq = 8000;                % Maximum frequency
num_mel_filts = 40;             % Number of mel filters
n_dct = 15;                     % Number of DCT co-efficients
Fs = 48000;                     % Sampling frequency
win_type = 'hamming window';    % Hamming window
nfft = 1024;

%% Record and save as wavfile

% Begin recording by clicking the "Record button".
recorder1 = audiorecorder(Fs,16,2);
to_record_input(recorder1)
pause(20);

% Store data in double-precision array.
my_recording = getaudiodata(recorder1);

% Convert to wav file
filepath = 'Test_Data.wav';
audiowrite(filepath,my_recording,Fs);

% Plot MFCC
[mfccs,fs_mfcc] = computing_mfccs(filepath,win_size,hop_size,min_freq,max_freq,num_mel_filts,n_dct,Fs, nfft, win_type);

% File playback
soundsc(my_recording,Fs);
