function h = rectfilt (N, wc)

% RECTFILT Creates Rectangular filter.
%   h = rectfilt(N, wc)
%   returns filter of order N and cutoff wc


    N = N + 1 - rem(N,2);
    
    n = -(N-1)/2 : (N-1)/2;
    
    h = wc/pi * sinc(wc * n );
    
    h = h/sum(h);
    
    
    
    
    
  return
    