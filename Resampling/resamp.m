function y = resamp(x, r)
% RESAMP Resample an input sequence x by a factor of r
%   to produce an output sequence y by a combination
%   of upsampling and downsampling.
%   For example,    y = resamp(x,1.5);
%   will upsample x by 3 and downsample by 2.
% normalized frequency from 0-1 corresponds to 0 --> pi
% n = round(1+20/fn);
% order increases as fn decreases
% h = firl(n, fn, kaiser(n, 5));

[L,M] = rat(r);
Lx = length(x);

x_up = zeros(1,Lx*L);
x_up(1:L:end) = x;  %upsample


wc = max(L,M);
fn = 1/wc;
n = round(1+20/fn);
h = L*fir1(n-1, fn, kaiser(n,5));
x_filt = conv(x_up, h, 'same');
y = x_filt(1:M:end);    %downsample

end
