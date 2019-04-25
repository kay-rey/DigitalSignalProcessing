function y = resamp(x, r)
% RESAMP Resample an input sequence x by a factor of r
%   to produce an output sequence y by a combination
%   of upsampling and downsampling.
%   For example,    y = resamp(x,1.5);
%   will upsample x by 3 and downsample by 2.

[L,M] = rat(r);
lengthX = length(x);
upsampleX = zeros(1,lengthX*L);
upsampleX(1:L:end) = x;  %this calulates the upsample
wc = max(L,M);
fn = 1/wc;
n = round(1+20/fn);
h = L*fir1(n-1, fn, kaiser(n,5));
x_filt = conv(upsampleX, h, 'same');
y = x_filt(1:M:end);    %this calculates the downsample

end
