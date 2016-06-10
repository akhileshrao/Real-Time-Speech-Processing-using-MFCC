function [features] = computing_features(mfccs,fs_mfcc, total_frames, num_mel_filts,Fs)
    j=1;
    Ts = 10;
    cepstral_coefficients = 15;     % No. of cepstral coefficients
    for i=1:fs_mfcc:length(mfccs)
        if (i+fs_mfcc-1 < length(mfccs))
            features(:,j) = mean(mfccs(2:15,i:i+fs_mfcc-1),2);
        else
            features(:,j) = mean(mfccs(2:15,i:length(mfccs)),2);
        end
        j=j+1;
    end
    
    % Size of feature matrix and time frames
    disp('Size of feature matrix = ')
    disp(size(features))
    log_filter_bank_energies = 20*log10(features);
    time_frames = [1:total_frames]*Ts*0.001+0.5*length(total_frames)/Fs;
    disp(size(time_frames))
    
    % Plot
    subplot(4,1,3)
    imagesc(time_frames, [1:num_mel_filts], log_filter_bank_energies); 
    axis xy; axis tight;
    xlim( [ min(time_frames) max(time_frames) ] );
    xlabel('Time(s)'); 
    ylabel('Channel index');
    title('Log (mel) filterbank energies');
    subplot(4,1,4)
    imagesc(time_frames, [1:cepstral_coefficients], mfccs);
    axis xy; axis tight;
    xlim([ min(time_frames) max(time_frames) ]);
    xlabel('Time(s)'); 
    ylabel('Cepstrum index');
    title('Mel frequency cepstrum');


end

