f = @(x) x'*x;
x0 = randn(15, 1);
y = fminunc(f, x0);

options = optimset('Display', 'iter', ... 
                   'PlotFcns', @optimplotfval);

[y, fval, exitflag, output] = fminunc(f, x0, options);

%adjust options as necessary
options = optimset('Display', 'none');

rec = zeros(21, 2);
for k=1:21
    [~, ~, exitflag, output] ... 
        = fminunc(f, randn(10, 1), options);
    rec(k, :) = [exitflag, output.funcCount];
end

[sum(rec(:, 1)>= 1), median(rec(rec(:, 1)>=1, 2))];
rec;