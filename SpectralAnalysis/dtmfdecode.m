function str = dtmfdecode(s, fs)
%   Kevin Baltazar Reyes
%   Engr 451 Spring 2018
%
%   DTMFDECODE Decode DTMF tones
%   str = decodedtmf(s, fs)
%   Accepts a array, s, which corresponds to the DTMF tones
%   sampled at fs
%   Produces a string transcript that decodes the tones.


f = 0.025*fs;
nf = floor(length(s)/f);
b = 1;
k = 1;
indx = 1;
indx2 = 1;

while k <= nf
    frame = s(b:b+f);
    E = sum(frame.^2);
    
    if E > 10
        first(indx) = b;
        
        while E > 10
            b = b+f;
            k = k+1;
            if b+f < length(s)
                frame = s(b:b+f);
                E = sum(frame.^2);
            else
                break
            end
        end
        last(indx2) = b;
    else
        b = b+f;
        k = k+1;
    end
    
    indx = indx + 1;
    indx2 = indx2 + 1;
end

first = first(find(first));
last = last(find(last));

for i = 1:length(first)
    x = first(i);
    l = last(i);
    w = (l-x)*2;
    y = s(x:l);
    Y = fft(y, w);
    Y = Y(25:length(Y)/2);
    [m n] = max(Y); % This finds the max freq
    Y(n) = 0;
    [m2 n2] = max(Y); % This finds the 2nd max freq
    
    f1 = fs*(n+25)/w;
    f2 = fs*(n2+25)/w;
    freq = f1 + f2;
    
    if freq > 941+1477
        str(i) = '#';
    elseif freq > 852+1477
        str(i) = '9';
    elseif freq > 941+1336
        str(i) = '0';
    elseif freq > 770+1477
        str(i) = '6';
    elseif freq > 852+1340
        str(i) = '8';
    elseif freq > 697+1477
        str(i) = '3';
    elseif freq > 941+1209
        str(i) = '*';
    elseif freq > 770+1336
        str(i) = '5';
    elseif freq > 852+1209
        str(i) = '7';
    elseif freq > 697+1336
        str(i) = '2';
    elseif freq > 770+1209
        str(i) = '4';
    elseif freq > 697+1209
        str(i) = '1';
    end
end
end