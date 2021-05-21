function [history,searchdir] = runfmincon
 
% Set up shared variables with OUTFUN
history.iter = [];
history.x = [];
history.fval = [];
searchdir = [];
N=rand();
v=100;
n=3;
beta=7;
x= @(x) [x(1), x(2), x(3)];

% call optimization
%x0 = [randn(10, 1), randn(10, 1), randn(10, 1)];
x0 = [3, 3, 3];
options = optimoptions(@fminunc,'OutputFcn',@outfun,... 
    'Display', 'iter', 'HessUpdate', 'dfp');
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
     f = (exp(N*v/(2*n)))*(x*x')^(beta/2);

 end
 

end