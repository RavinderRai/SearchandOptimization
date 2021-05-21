%x = [a; b]
N=rand();
v=100;
n=3;
beta=7;
%f = @(x) (exp(N*v/(2*n)))*(x(1)*x(1) + x(2)*x(2) + x(3)*x(3))^(beta/2);
f = @(x) (x(1)*x(1) + x(2)*x(2) + x(3)*x(3));
%x0 = [randn(10, 1), randn(10, 1), randn(10, 1)];
x0 = [3, 3, 3];
%y = fminunc(f, x0);



%options = optimset('bfgs', 'Display', 'iter', ... 
 %                  'PlotFcns', @optimplotfval);

               
option = optimoptions(@fminunc,'Display', 'iter', 'PlotFcns', @optimplotfval);
 
[x, fval, exitflag, output] = fminunc(f, x0, option);


%opt = optimoptions(@fminunc, 'OutputFcn',@outfun);
%[history searchdir] = runfmincon

%adjust options as necessary
options = optimset('Display', 'none');

rec = zeros(21, 2);
for k=1:21
    [~, ~, exitflag, output] ... 
        = fminunc(f, randn(10, 1), options);
    rec(k, :) = [exitflag, output.funcCount];
end

[sum(rec(:, 1)>= 1), median(rec(rec(:, 1)>=1, 2))];