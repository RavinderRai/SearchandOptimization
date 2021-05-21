function [flist] = Recombination(n, gamma0, lambda, f)
    flst = zeros(1, 5000);
    %fylst = zeros(1, lambda);
    k = 1;
    gammak = gamma0;
    x0 = randn(n, 1);
    xk = x0;
    while f(xk)>1e-5
        zk = randn(n, 1, lambda);
        yk = xk + gammak*zk(:, :, 2);
        z = zk(:, :, 3);
        fvaly = f(yk);
        i=1;
        while i < lambda
            zk1 = zk(:, :, 3);
            yk1 = xk + gammak*zk1;
            fvaly1 = f(yk1);
            if fvaly > fvaly1
                fvaly = fvaly1;
            end
            i = i + 1;
        end
        fvalx = f(xk);
        if fvaly < fvalx
            xk = yk;
            flst(k) = fvaly;
            gammak = gammak*exp(0.8/n);
        else
            flst(k) = fvalx;
            gammak = gammak*exp(-0.2/n);
        end
        k = k + 1;
    end
    flist = flst(1:k-1);
end