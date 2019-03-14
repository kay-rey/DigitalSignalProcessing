% Kevin Baltazar Reyes
% ENGR 451

function y=cirConv(x,h)
lx=length(x);
lh=length(h);
l=max(lx,lh);
X=[x zeros(1,l-lx)];
H=zeros(l);
H(1:lh)=h;
for j=1:l-1
    for i=1:l-1
        H(i+1,j+1)=H(i,j);
    end
    H(1,j+1)=H(l,j);
end
y=H*X';
end