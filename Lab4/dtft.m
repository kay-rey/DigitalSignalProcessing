function y = dtft(x, w)

% DTFT Evaluate the DTFT of Matlab sequence object, x, at radial frequencies
% given by double array w. Return a double array, y.
n = [x.offset: x.offset + length(x.data)-1]; %sequence of offsets
Q = n'*w; %transpose n to multiply with w
y = x.data*exp(-1i*Q);  %y = (x)e^(-jw*x.offset)
end