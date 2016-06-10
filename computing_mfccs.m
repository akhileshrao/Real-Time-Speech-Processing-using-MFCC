function [mfccs,fs_mfcc] = computing_mfccs(filepath,win_size,hop_size,min_freq,max_freq,num_mel_filts,n_dct, Fs, nfft, win_type)

% Reading input and converting stereo to mono wavfile
[input,Fs] = audioread(filepath);
time = (0:length(input)-1)/Fs;
figure(2)

% Plot
subplot(4,1,1)
plot(time, input);
xlabel('Time(s)'); 
ylabel('Amplitude'); 
title('Speech plot');

% Stereo to Mono
input = input(:,1);
no_of_DFT_points = 1024;


% Computing spectrogram with Hamming window and given window and hop size
w = hamming(win_size);
total_frames = round((length(input)/hop_size));
disp('Total number of frames = ');
disp(total_frames)

% Plot spectrogram
[S,F,T] = plotting_spectrogram(filepath, win_size, hop_size, win_type, Fs, nfft);
for frame_no=1:total_frames
    
    start_index = hop_size*(frame_no-1)+1;
    end_index = start_index + win_size - 1;
    
    if (end_index > length(input))
            input_frame = [input(start_index:length(input)); zeros(end_index - length(input),1)];
            break;
        else
            input_frame = input(start_index:end_index);
    end

    spectrogram1(frame_no,:) = fft(input_frame);
end

% Length of spectrogram
disp('Size of spectrogram is = ')
disp(size(spectrogram1))


% Creating mel filter bank
mel_freq_lower = hertz2mel(min_freq);
mel_freq_upper = hertz2mel(max_freq);

mel_spacing = (mel_freq_upper - mel_freq_lower)/(num_mel_filts+1);

mel_filter_cutoffs(1) = mel_freq_lower;
for filter_no = 1:num_mel_filts
    mel_filter_cutoffs(filter_no+1) = mel_freq_lower + filter_no*mel_spacing;
end

mel_filter_cutoffs(filter_no+2) = mel_freq_upper;

linear_filter_cutoffs = mel2hertz(mel_filter_cutoffs);
linear_filter_cutoffs_discrete = round(linear_filter_cutoffs*no_of_DFT_points/Fs);
for i = 2:length(linear_filter_cutoffs_discrete)-1
    filter(i-1,1:no_of_DFT_points) = 0;
    for j = linear_filter_cutoffs_discrete(i-1):1:linear_filter_cutoffs_discrete(i+1)
        if (j == linear_filter_cutoffs_discrete(i))
            filter(i-1,j+1) = 1;
        elseif (j < linear_filter_cutoffs_discrete(i))
            filter(i-1,j+1) = (j-linear_filter_cutoffs_discrete(i-1))/(linear_filter_cutoffs_discrete(i) - linear_filter_cutoffs_discrete(i-1));
        else
            filter(i-1,j+1) = (linear_filter_cutoffs_discrete(i+1)-j)/(linear_filter_cutoffs_discrete(i+1) - linear_filter_cutoffs_discrete(i));
            
        end
        
    end
    
end

disp('Size of filter is = ');
disp(size(filter));
disp('Length of spectrogram is = ')
disp(length(spectrogram1))

% Computing mel power spectrum and its dct
for j=1:length(spectrogram1)
    for i =1:num_mel_filts
        mel_filtered_signal(i,j) = 10*log(sum((spectrogram1(j,:).*filter(i,:)).^2));
        %mel_filtered_signal(i,j) = mel_filtered_signal(i,j)/sum(filter(i,:).^2);   % Normalising by filter energy
    end
    mfccs_full(:,j) = dct(mel_filtered_signal(:,j));
    mfccs = abs(mfccs_full(1:n_dct,:));
end


disp('Size of MFCC is = ')
disp(size(mfccs'));
hop_length_sec = hop_size/Fs;
fs_mfcc = round(1/hop_length_sec);
disp('Value of fs_mfcc is = ')
disp(fs_mfcc)
features = computing_features(mfccs,fs_mfcc, total_frames, num_mel_filts,Fs);

end
