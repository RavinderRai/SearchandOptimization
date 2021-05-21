function [history,searchdir] = runfminunc(n, eta, target, Hesupdate, stopeval, O)
 
%the idea for this code came from the following link
%https://www.mathworks.com/help/releases/R2015b/optim/ug/output-functions.html

% Set up shared variables with OUTFUN
history.iter = [];
%note that we never end up using the x values, so this need not be store
%and should be removed
history.x = [];
history.fval = [];
history.fcount = [];
searchdir = [];




% The objective limit is the target function value, but the algorithm
% sometimes stopped early because of maxfunctionevaluations exceeding the
% default setting, and similarly for the optimality tolerance, so manual
% values are set here to allow the algorithm to reach the target without
% any of these issues

x0 = randn(n, 1);
options = optimoptions(@fminunc,'OutputFcn',@outfun,... 
    'Display', 'iter', 'HessUpdate', Hesupdate, 'ObjectiveLimit', target, ...
    'OptimalityTolerance', 1e-90, 'StepTolerance', 1.0e-30, ...
    'FunctionTolerance', 1.0e-300,'MaxFunctionEvaluations', stopeval);
y = fminunc(@objfun,x0, options);
 
 function stop = outfun(x,optimValues,state)
     stop = false;
 
     switch state
         case 'init'
             hold on
         case 'iter'
         % Concatenate current point and objective function
         % getting these values for plotting semilog plots later
           history.fval = [history.fval; optimValues.fval];
           history.x = [history.x; x];
           history.iter = [history.iter; optimValues.iteration];
           history.fcount = [history.fcount; optimValues.funccount];
         % Concatenate current search direction with 
         % searchdir, note that searchdir was never used here, so it can
         % and should be removed
           searchdir = [searchdir;... 
                        optimValues.searchdirection'];
           plot(optimValues.iteration,optimValues.fval,'Marker',...
               'd','MarkerFaceColor','blue');
           title('Sequence of Points Computed by fminunc');
         case 'done'
             hold off
         otherwise
     end
 end
 
%this is the test problem function, the non-quadratic sphere
function f=objfun(x)
  n = size(x,1); if n < 2 error('dimension must be greater one'); end
  x = O*x;
  f=eta.^((0:n-1)/(n-1)) * x.^2;
end   
 

end