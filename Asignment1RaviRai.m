%here we do minimize the sphere with a target of nearly zero for three
%different values of dimenion, for all different types of hessian updates

[history1,~] = runfminunc(50, 10, 1e-6, 'bfgs');
[history2,~] = runfminunc(50, 10, 1e-6, 'dfp');
[history3,~] = runfminunc(50, 10, 1e-6, 'steepdesc');
[history4,~] = runfminunc(100, 10, 1e-6, 'bfgs');
[history5,~] = runfminunc(100, 10, 1e-6, 'dfp');
[history6,~] = runfminunc(100, 10, 1e-6, 'steepdesc');
[history7,~] = runfminunc(200, 10, 1e-6, 'bfgs');
[history8,~] = runfminunc(200, 10, 1e-6, 'dfp');
[history9,~] = runfminunc(200, 10, 1e-6, 'steepdesc');


%we plot everything here on the same graph for comparison

semilogy(history1.fcount, history1.fval, 'marker', 'd', ...
    'MarkerFaceColor','red');
hold on;
title('Non-Quadratic Sphere Minimization Varying Dimension');
ylabel('log(function value)');
xlabel('Function Count');
semilogy(history2.fcount, history2.fval, 'marker', 'd', ...
    'MarkerFaceColor','green');

semilogy(history3.fcount, history3.fval, 'marker', 'd', ...
    'MarkerFaceColor','blue');

semilogy(history4.fcount, history4.fval, 'marker', 'o', ...
    'MarkerFaceColor','red');

semilogy(history5.fcount, history5.fval, 'marker', 'o', ...
    'MarkerFaceColor','green');

semilogy(history6.fcount, history6.fval, 'marker', 'o', ...
    'MarkerFaceColor','blue');

semilogy(history7.fcount, history7.fval, 'marker', 'square', ...
    'MarkerFaceColor','red');

semilogy(history8.fcount, history8.fval, 'marker', 'square', ...
    'MarkerFaceColor','green');

semilogy(history9.fcount, history9.fval, 'marker', 'square', ...
    'MarkerFaceColor','blue');
semilogy(history10.fcount, history10.fval, 'marker', '*', ...
    'MarkerFaceColor','red');

semilogy(history11.fcount, history11.fval, 'marker', '*', ...
    'MarkerFaceColor','green');

semilogy(history12.fcount, history12.fval, 'marker', '*', ...
    'MarkerFaceColor','blue');
legend('bfgs50', 'dfp50', 'steepdesc50', 'bfgs100', 'dfp100', ...
    'steepdesc100', 'bfgs200', 'dfp200', 'steepdesc200','Location', ...
    'northeast')
hold off



%uncomment the beta for which plot you are looking for
%r is the number of different target values the algorithm will look for
%r ranges from 0 to the largest target value, which is 10000 here
r=25;
target = 10000; %this is the largest target value, and thus furthest from 0

%note the larger values of beta have runtimes around 30min
beta = 10;
%beta = 25;
%beta = 40;

bfgsarr = zeros(3, r);
steepdescarr = zeros(3, r);
dfparr = zeros(3, r);

%this for loop is to get many runs and then take the median value so that 
%we get a result that will be more likely to reproduce.

%for the higher values of beta, the runtime is around 30 min, but you can
%fix this by changing the for loop below by having only 3 or 5 iterations

for i = 1:7
    [time, fracfuncbfgs, fracfuncsteepdesc, ...
        fracfuncdfp] = SphereFminunc(beta, r, target);
    bfgsarr(i, :) = fracfuncbfgs;
    steepdescarr(i, :) = fracfuncsteepdesc;
    dfparr(i, :) = fracfuncdfp;
end

%here we plot the median results and take them to be final results that
%should be more likely to be reproducible as compared to just one run
plot(time, median(bfgsarr), 'marker', 'o', ...
    'MarkerFaceColor','red');
hold on;
title('Cumulative Runtime Distribution');
ylabel('Proportion of Functions');
xlabel('Runtime (seconds)');
plot(time, median(steepdescarr), 'marker', 'o', ...
    'MarkerFaceColor','blue');
plot(time, median(dfparr), 'marker', 'o', ...
    'MarkerFaceColor','green');
legend('bfgs', 'steepdesc', 'dfp', 'Location','southeast')

