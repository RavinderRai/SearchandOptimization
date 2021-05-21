function [flist, fcountlist] = ES1(n, gamma0, beta, target)
%making lists of zeros for storing variables to plot later, going to 9000
%because it is an arbitrarily large value
    flst = zeros(1, 9000);
    fcountlst = zeros(1, 9000);
    %k is the counting number
    k = 1;
    gammak = gamma0;
    x0 = randn(n, 1);
    xk = x0;
    fvalx = f(xk);
    fcount = 1;
    while fvalx>target
        zk = randn(n, 1); 
        yk = xk + gammak*zk;
        %compute function values here so we don't also have to do so in the
        %if statements
        fvaly = f(yk);
        fvalx = f(xk);
        fcount = fcount + 2;
        if fvaly < fvalx
            xk = yk;
            fvalx = fvaly; %so the while loop checks the correct value
            flst(k) = fvaly;
            %this is the 1/5 rule
            gammak = gammak*exp(0.8/sqrt(n+1));
        else
            flst(k) = fvalx;
            gammak = gammak*exp(-0.2/sqrt(n+1));
        end
        fcountlst(k) = fcount;
        k = k + 1;
    end
    %get the stored values, but drop all extra zeros that weren't used
    flist = flst(1:k-1);
    fcountlist = fcountlst(1:k-1);

 %test function
 function f = f(x)
     f = (x'*x)^(beta/2);

 end    

end