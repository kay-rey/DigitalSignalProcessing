function [sr, sc] = separate(s, fs)

% SEPARATE Separates row and column tone for a DTMF tones
% [sr, sc] = separate(s, fs)
% produces row and column sound files sr and sc
% for a sound file, s, of DTMF tones that have been % digitized at sample rate, fs.
%% Part 1 Make filters
% Create lowpass FIR Kaiser filter of appropriate order using % your kaiserparams and kaiserfilt functions
% Create highpass FIR Kaiser filter of appropriate order
%  Perform filtering


    fc = (1209+941)/2;
    wc = 2*fc/fs;
   
    deltaOmega = (2*1209/fs) - (2*941/fs);
   
    [N,beta]=kaiserparams(deltaOmega,.001);
   
    lpf = kaiserfilt(N,wc,beta);
   

    sr = conv(s,lpf);
   

    n = (N-1)/2;
    
    hpf = -lpf;
    
    hpf(n+1) = hpf(n+1) + 1;
   

    sc = conv(s,hpf);

end