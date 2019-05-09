function [N, beta] = kaiserparams(deltaOmega, delta)

%[N, beta] = kaiserparams (deltaOmega, delta)

% KAISERPARAMS Returns Kaiser design parameters N and beta.


    deltaOmega = deltaOmega*pi;

    A = -20*log10(delta);
   

    N = ceil((A-8)/(2.285*deltaOmega));

   
    if A < 21
        beta = 0;
    end

    if 21 <= A && A <= 50
        beta = 0.5842*((A-21)^.4)+.07886*(A-21);
    end

    if A > 50
        beta = 0.1102*(A-8.7);
    end   


end