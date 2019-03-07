function y = conv_rt(x,h)
% Convolve two finite-length arrays, x and h returning array, y
h_hat = h(end:-1:1);
x_hat = [zeros(1,length(h)-1) x zeros(1,length(h)-1)];
y = zeros(1,length(x)+length(h)-1);

for i=1:length(x)+length(h)-1
    y(i) = sum(h_hat.*x_hat(i:i+length(h)-1));
end
end