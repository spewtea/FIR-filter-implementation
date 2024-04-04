clc;clear;close;

fs = 8000; %Sampling freq
t = 0:1/fs:1;
f = 50;  %Signal freq
 
x = 10*sin(2*pi*f*t);


signal = awgn(x,50,'measured');

fc =500; 
[b, a] = fir1(5, (2*fc)/fs,"low");

filtered_signal = filter(b,a,signal);

figure
plot(t, filtered_signal, 'b', t, signal, 'r');
xlabel('Time (s)');
ylabel('Amplitude (V)');
title("After Filtering")
legend('Filtered Signal', 'Noisy Signal');

%finding snr ratio 
signal_power = rms(x)^2;
noise_power = rms(signal)^2;
filtered_noise_power = rms(filtered_signal-x)^2;

snr_before = 10*log10(signal_power/noise_power);
snr_after = 10*log10(signal_power/filtered_noise_power);

fprintf('SNR before filtering: %f dB\n', snr_before);
fprintf('SNR after filtering: %f dB\n', snr_after);