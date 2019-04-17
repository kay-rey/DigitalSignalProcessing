function plot_magph(x,w)
% PLOT_MAGPH Plot the magnitude and phase of Matlab sequence object, x
% at frequencies given by array w

z = mag_phase(dtft2(x, w));

subplot(2, 1, 1),
plot(w/pi,z.mag,'linewidth',2);
grid on;
ylabel('Magnitude');
ylim([min(z.mag)-1 max(z.mag)+1]);  % +/- y limits set to magnitudes

subplot(2, 1, 2),
plot(w/pi, z.phase/pi,'linewidth',2);
ylim([-1 1]);   %highest possible values of phase
grid on;
ylabel('Phase');
xlabel('w(rad/pi)');

end