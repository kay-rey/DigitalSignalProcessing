function h = kaiserfilt(N, wc, beta)

% KAISERFILT Creates FIR Kaiser Filter.

    n = (N-1)/2;
    
    M = linspace(-n,n,N);
   

    wn = besseli(0, beta .* sqrt(1-(2 .* M/(N-1)).^2)) ./ besseli(0, beta);

    h = (wc .* sinc(wc * M)) .* wn;
    h = h/sum(h);


end
