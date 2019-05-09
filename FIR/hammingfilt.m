function h = hammingfilt(N, wc)

%h = hammingfilt(N,wc)

n = (N - 1)/2;

M = -n:n;

h = wc/pi * sinc(wc * M );
    
w = 0.54 + 0.46 .* cos(2.*pi.*M/(N-1));

h = h .* w;

h = h/sum(h);


end
