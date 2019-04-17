function fplot(b, a)
w = linspace(0,1,256);
numA = a;
numB = b;
% take the dtft of the num and den
ftB = fft(numB,512);
ftA = fft(numA,512);

%-------- H = B/A ---------
mH = abs(ftA./ftB); %Magnitude
fH = angle(ftA./ftB); %Phase
%disp(fH)

%----Magnitude Plot----
subplot(2,1,1);
plot(w,mH(1:256));
ylim([0 1.1*max(mH)]);
ylabel('|H(\omega)|');
xlim([0 1]);
%disp(mH)



%----Frequency Plot---
subplot(2,1,2);
plot(w,fH(1:256)./pi,w,0,'k'); 
%disp(w)
%disp(fH)
xlim([ 0 1]);
ylim([-1 1]);
ylabel('\angleH(\omega)(fraction of \pi)');
xlabel('w (fraction of \pi)');
end