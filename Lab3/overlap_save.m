function y = overlap_save(x, h, lc)
% Code to perform Convolution using Overlap Save Method

M=length(h);
lx=length(x);



r=rem(lx,lc);
x1=[x zeros(1,lc-r)];
nr=(length(x1))/lc;
h1=[h zeros(1,lc-1)];
for k=1:nr
    Ma(k,:)=x1(((k-1)*lc+1):k*lc);
    if k==1
        Ma1(k,:)=[zeros(1,M-1) Ma(k,:)];
    else 
        Ma1(k,:)=[Ma(k-1,(lc-M+2):lc) Ma(k,:)];        
    end
     Ma2(k,:)=ifft(fft(Ma1(k,:)).*fft(h1));
end
Ma3=Ma2(:,M:(lc+M-1));
y1=Ma3';
y=y1(:)';
end