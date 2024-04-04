clc; clear; close;

fs = 9000; %Sampling
t = 0:1/fs:1;
f = 30; %Signal

x = sin(2*pi*f*t); %Generate signal

y = awgn(x,20,"measured");


fc = 550;
[b,a] = butter(4, (2*fc)/fs);

z = filter(b,a,y);

figure
plot(t, z, 'b', t, y, 'r');
xlabel('Time (s)');
ylabel('Amplitude (V)');
title("After Filtering")
legend('Filtered Signal', 'Noisy Signal');

%FINDING SNR

signal_power = rms(x)^2;
noise_power = rms(y)^2;
filtered_noise_power = rms(z-x)^2;

snr_before = 10*log10(signal_power/noise_power);
snr_after = 10*log10(signal_power/filtered_noise_power);

fprintf('SNR before filtering: %f dB\n', snr_before);
fprintf('SNR after filtering: %f dB\n', snr_after);