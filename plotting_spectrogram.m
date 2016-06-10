function [S,F,T] = plotting_spectrogram(filepath, win_size, hop_size, win_type, Fs, nfft)


N = win_size;
h = hop_size;
overlap = N-h;

switch win_type 
    case 'hamming window'
       win_type = hamming(N);
end
[y,Fs] = audioread(filepath);
y = y(:,1);

% Plotting Spectrogram
subplot(4,1,2)
[S,F,T] = spectrogram(y,win_type,overlap,nfft,Fs);
SS = 20*log10(abs(S));
imagesc(T,F,SS);
axis xy; axis tight;
% colorbar('location','EastOutside');
xlabel('Time(sec)');
ylabel('Frequency(Hz)');

end
