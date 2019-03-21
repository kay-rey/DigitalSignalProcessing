% Kevin Baltazar Reyes
% ENGR 451

function y = overlap_save(x, h, lc)
% Code to perform Convolution using Overlap Save Method
M=length(h);
lx=length(x);
%lc=M-1;
L=lc-M+1;
r=floor(rem(lx,lc));
%L=length(lc);
%lc=M-1;
%N=lc+M-1;
%r*lc-lx
x1=[ x zeros(1,lc-r)]; %padding x[n]
nr=floor((length(x1))/lc);
h1=[h zeros(1,lc-1)]; %padding h[n]

for k=1:nr          %createa unit vector K with elements [1,1+1,1+2,...nr]
    Ma(k,:)=x1(((k-1)*lc+1):k*lc);
    if k==1
        Ma1(k,:)=[zeros(1,(M-1)) Ma(k,:)];
    else 
        Ma1(k,:)=[Ma(k-1,(lc-M+2):lc) Ma(k,:)];        
    end
     Ma2(k,:)=ifft(fft(Ma1(k,:)).*fft(h1));
end

Ma3=Ma2(:,M:(lc+M-1));
y1=Ma3';
y=y1(:)';
end