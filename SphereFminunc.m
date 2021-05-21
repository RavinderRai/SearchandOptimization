function [time, fracfuncbfgs, fracfuncsteepdesc, ...
    fracfuncdfp] = SphereFminunc(beta, r, target)
%r is the number of runs done according to the target (split up evenly from
%0 to target)
%target is the largest - so furthest from the minimum - 
%target function value aimed for, and we will go
%down to the known minimum target, that being zero, or close to it

%c is just a counter dummy variable

%this for loop gets runtimes for different target values and makes a list
%of them
tbfgs=zeros(1, r);
c=0;
for i = linspace(1e-7, target, r)
    c=c+1;
    tic
    [~,~] = runfminunc(100, beta, i, 'bfgs');
    tbfgs(c) = toc;
time = linspace(min(tbfgs), max(tbfgs), r);
end


%this for loop calculates the number of targets reached given a certain
%runtime, and stores the numbers in an array and divides them by the number
%of runs (total number of problems attempted) to get fractional values for
%the cumulative run time distribution plot
c=0;
fracfuncbfgs = zeros(1, r);
for i = linspace(1, r, r)
    c=c+1;
    fracfuncbfgs(c) = sum((tbfgs<=time(i))/r);
end


%this is the same as above but for steepdesc hessian update
tsteepdesc=zeros(1, r);
c=0;
for i = linspace(1e-7, target, r)
    c=c+1;
    tic
    [~,~] = runfminunc(100, beta, i, 'steepdesc');
    tsteepdesc(c)=toc;
time = linspace(min(tsteepdesc), max(tsteepdesc), r);
end

c=0;
fracfuncsteepdesc=zeros(1, r);
for i = linspace(1, r, r)
    c=c+1;
    fracfuncsteepdesc(c) = sum((tsteepdesc<=time(i))/r);
end


%this is the same as above but for dfp hessian update

c=0;
tdfp=zeros(1, r);
for i = linspace(1e-7, target, r)
    c=c+1;
    tic
    [~,~] = runfminunc(100, beta, i, 'dfp');
    tdfp(c)=toc;
time = linspace(min(tdfp), max(tdfp), r);
end

c=0;
fracfuncdfp=zeros(1, r);
for i = linspace(1, r, r)
    c=c+1;
    fracfuncdfp(c) = sum((tdfp<=time(i))/r);
end

time = linspace(0, max([tsteepdesc, tbfgs, tdfp]), r);

%could do the plotting in this function instead

%{
plot(time, fracfuncbfgs, 'marker', 'o', ...
    'MarkerFaceColor','red');
hold on;
title('Cumulative Runtime Distribution');
ylabel('Proportion of Functions');
xlabel('Runtime (seconds)');
plot(time, fracfuncsteepdesc, 'marker', 'o', ...
    'MarkerFaceColor','blue');
plot(time, fracfuncdfp, 'marker', 'o', ...
    'MarkerFaceColor','green');
legend('bfgs', 'steepdesc', 'dfp', 'Location','southeast')
%}
end
