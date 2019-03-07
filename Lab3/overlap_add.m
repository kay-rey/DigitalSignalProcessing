
function y = overlap_add(x, h, lc)
Nx=length(x);
Mh=length(h);
M1=Mh-1;
R=rem(Nx,lc);
N=lc+M1; %N should not be more than 500

%Padding with 0's
x=[x zeros(1,lc-R)];
h=[h zeros(1,N-Mh)];

%floor() rounds the elements of K to the nearest integers less than 
%or equal to K.
K=floor(Nx/lc);
y=zeros(K+1,N);
z=zeros(1,M1);

for k=0:K
xp=x(lc*k+1:lc*k+lc);
xk=[xp z];
y(k+1,:)=cirConv(xk,h);
end

p=lc+M1;
for i=1:K
y(i+1,1:Mh-1)=y(i,p-M1+1:p)+y(i+1,1:Mh-1);
end

%Vectors 
z1=y(:,1:lc)';  %Index l & lc columns
y=(z1(:))';
end