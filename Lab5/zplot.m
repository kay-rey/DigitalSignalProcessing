function zplot(b,a)
% ZPLOT Plot a zero-pole plot. 
% -1 -nb 
% B(z) b(1) + b(2)z + .... + b(nb+1)z 
% H(z) = ---- = --------------------------------- 
% -1 -na 
% A(z) a(1) + a(2)z + .... + a(na+1)z 
% 
% zplot(b, a) plots the zeros and poles which determined by vectors 
% b and a 
% The plot includes the unit circle and axes for reference, plotted 
% in black. 
% Each zero is represented with a blue 'o' and each pole with a red
% 'x' on the plot.

w = linspace(0,2*pi,64);
plot(exp(j*w),'color','k');
hold all;
line([-2; 2], [0;0],'color', 'k');
line([0;0], [-2;2], 'color', 'k');

poles = roots(a);
zers  = roots(b);

a_r= real(poles);
a_i= imag(poles);
b_r= real(zers);
b_i= imag(zers);

plot(a_r ,a_i, 'rx');
plot(b_r,b_i, 'bo');

end