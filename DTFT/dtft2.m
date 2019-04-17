function y = dtft2(x,w)
% DTFT2 Evaluate the DTFT of Matlab sequence object, x, at frequencies
% given by array w.
% Return values are a structure with y.real (real part) and y.imag
% (imaginary part)

n = (x.offset:x.offset + length(x.data)-1);
Q = n'*w;
dtft = x.data*exp(-1i*Q);

    for n=1:length(dtft)
        mag = abs(dtft(n)); %magnitude = sqrt[((x.real)*(x.real)) + ((x.imag)*(x.imag))]
        ang = angle(dtft(n));
        y.real(n) = mag*cos(ang);
        y.imag(n) = mag*sin(ang);
    end
end


