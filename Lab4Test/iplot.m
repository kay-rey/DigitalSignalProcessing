function iplot(b, a)
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
  E = sum(abs(h).^2);
  C = find(cumsum(abs(h).^2) >= 0.999*E);
  N = C(1);
end

stem(-n:N-n-1, h(1:N))
xlim([ -n N-n]);


end