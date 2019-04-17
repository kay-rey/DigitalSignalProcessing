function y = mag_phase(x)
% MAG_PHASE Input argument is a structure with x.real and x.imag
% Return values are y.mag (magnitude) and y.phase (phase in radians)

mag = sqrt(((x.real).*(x.real))+((x.imag).*(x.imag)));
P = zeros(1,length(x.real));

for n=1:length(x.real)
    P(1,n) = atan2(x.imag(n), x.real(n));
    y.mag = mag;
    y.phase = P;
end
end
