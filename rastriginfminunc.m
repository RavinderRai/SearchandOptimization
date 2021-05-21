function [history,searchdir] = rastriginfminunc(n, scale, Hessupdate)
 
% Set up shared variables with OUTFUN
history.iter = [];
history.x = [];
history.fval = [];
history.fcount = [];
searchdir = [];




% call optimization

x0 = randn(n, 1);
options = optimoptions(@fminunc,'OutputFcn',@outfun,... 
    'Display', 'iter', 'HessUpdate', Hessupdate, 'ObjectiveLimit', 1e-10, ...
    'OptimalityTolerance', 1e-50, 'MaxFunctionEvaluations', 100000, ...
    'StepTolerance', 1e-12);
y = fminunc(@objfun,x0, options);
 
 function stop = outfun(x,optimValues,state)
     stop = false;
 
     switch state
         case 'init'
             hold on
         case 'iter'
         % Concatenate current point and objective function
         % value with history. x must be a row vector.
           history.fval = [history.fval; optimValues.fval];
           history.x = [history.x; x];
           history.iter = [history.iter; optimValues.iteration];
           history.fcount = [history.fcount; optimValues.funccount];
         % Concatenate current search direction with 
         % searchdir.
           searchdir = [searchdir;... 
                        optimValues.searchdirection'];
           plot(optimValues.iteration,optimValues.fval,'Marker',...
               'd','MarkerFaceColor','blue');
         % Label points with iteration number and add title.
         % Add .15 to x(1) to separate label from plotted 'o'
           %text(x(1)+.15,x(2),... 
            %    num2str(optimValues.iteration));
           title('Sequence of Points Computed by fminunc');
         case 'done'
             hold off
         otherwise
     end
 end
 
 function f = objfun(x)
     f = (x'*x) + scale*(n - sum(cos(2*pi*x)));

 end
 

end