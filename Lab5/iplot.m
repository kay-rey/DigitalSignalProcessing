function iplot(b,a)
% IPLOT Impulse response of system.
% IPLOT(B,A,N) is the N-point impulse response
% of the filter B/A:
% -1 -nb
%        B(z) b(1) + b(2)z + .... + b(nb+1)z
% H(z) = ---- = ---------------------------------  -1 -na
%        A(z) a(1) + a(2)z + .... + a(na+1)z
%
% given numerator and denominator coefficients in vectors B and A.
% N is specified according to the following rule:
% If h[n] FIR, then N = length(h);
% If h[n] is IIR and increasing (i.e. |h[n]|-->inf as n-->inf),
% then N = 20;
% If h[n] is IIR and decreasing (i.e. |h[n]|-->0 as n-->inf),
% then the maximum N is determined such that
% rms value of h(1:N) = 0.999 * rms value of h(1:1000).
% However, in this case, N must also be chosen such that 10 <= N <= 10

x = [1 zeros(1,999)];

na=find(a,1);
nb=find(b,1);
h = filter(b(nb:end),a(na:end),x);
m = roots(a);   %poles of system
n=na-nb;

if m==0   %if we have no poles, system is FIR
    N = length(h);  %finite length h
    
elseif abs(m)>1   %nonstable IIR System (poles outside unit circle)
    N = 20; %finite length 20
    
else
    E = sum(h.^2);
    C = find(cumsum(h.^2 >= 0.999*E));
    N = C(1);
    stem(-n:N-1, h(1:N), 'filled');
end
end