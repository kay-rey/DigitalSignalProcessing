function ph = magdb(h)

%MAGDB Display magnitude of Fourier transform of h(n) on a 
%a db scale.
% ph = magdb(h)

% if (nargout)
%varargout = {ph}; 
%varargout = magdb(h)

% function varargout = magdb(h)
%MAGDB display magnitude of fourier transform of h[n] on a db scale
      

H = fft(h, 1024);
M = abs(H(1:512));
y = db(M);

x = linspace(0,pi,512)/pi;
ph = plot (x,y);

grid on;

 ylabel('|X( \omega )|');
 xlabel('\omega (rad/\pi)');  
 
 
 
end


