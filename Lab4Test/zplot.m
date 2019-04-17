function zplot(b, a)
%----Unit Circle----------
w = linspace(0,2*pi,64);
plot(exp(j*w),'color','k');
hold all;
line([-2; 2], [0;0],'color', 'k');
line([0;0], [-2;2], 'color', 'k');

%-----Poles/Zeros----------
p = roots(a);
z  = roots(b);

aR= real(p);
aI= imag(p);
bR= real(z);
bI= imag(z);

plot(aR,aI, 'bo');
plot(bR,bI, 'rx');
if (sum(p)==0)
	plot(0,0,'rx');
end

%------Set Axis-------

if min(aR) < min(bR)
	xmin = min(aR);
elseif min(bR)< -1
	xmin = min(bR);
else 
	xmin = -1;
end

if min(aI) < min(bI)
	ymin = min(aI);
elseif min(bI)< -1
	ymin = min(bI);
else 
	ymin = -1;
end

axis equal;
xlim([xmin*1.1 xmin*-1.1]);
ylim([ymin*1.1 ymin*-1.1]);

end