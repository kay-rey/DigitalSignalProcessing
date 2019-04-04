function fplot(b,a)
% FPLOT Z-transform frequency response.
% FPLOT(B,A,N) is the 256-point complex frequency response
% of the filter B/A:
% -1 -nb
% jw B(z) b(1) + b(2)z + .... + b(nb+1)z
% H(e) = ---- = ---------------------------------
% -1 -na
% A(z) a(1) + a(2)z + .... + a(na+1)z
% given numerator and denominator coefficients in vectors B and A.
% The frequency response is evaluated at 256 points equally spaced
% around the upper half of the unit circle.
% If A isn't specified, it defaults to [1].

B=fft(b,512);
A=fft(a,512);
H = B./A;


ax = 0:1/((length(H)/2)-1):1;
subplot(2,1,1);
ph = plot(ax,(abs(H(1:(length(H)/2)))));
grid on;
set(ph,'linewidth',2);
ylabel('|X( \omega )|');
xlabel('\omega (rad*\pi)');
XL = xlim;
xlim([0 XL(2)]);


subplot(2,1,2);
imagH = imag(H(1:length(H)/2));
realH = real(H(1:length(H)/2));
phase = unwrap(atan2(imagH,realH));
phase2 = phase/pi;
pp = length(phase2);
for i=1:pp
    while phase2(i)>1
        phase2(i) = phase2(i)- 2;
    end
    while phase2(i)<-1
        phase2(i) = phase2(i)+ 2;
    end
end


phase2(103:114);

ph2=plot(ax,phase2);
grid on;
set(ph2,'linewidth',2);
ylabel('\angle(X) ');
xlabel('\omega (rad*\pi)');
ylim([-1 1]);


end