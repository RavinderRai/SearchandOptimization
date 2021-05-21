function [flist, fcountlist] = ES1elli(n, eta, gamma0, target, O, stopeval)
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
        %fvalx = f(xk);
        fcount = fcount + 1;
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
        display([fcountlst(k), fvalx]);
        k = k + 1;    
    if fcount > stopeval
        break
    end
    end
    %get the stored values, but drop all extra zeros that weren't used
    flist = flst(1:k-1);
    fcountlist = fcountlst(1:k-1);


 %test function
function f=f(x)
  n = size(x,1); if n < 2 error('dimension must be greater one'); end
  x = O*x;
  f=eta.^((0:n-1)/(n-1)) * x.^2;
end   

end