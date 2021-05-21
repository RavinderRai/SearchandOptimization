[history1,~] = ellipsoidfminunc(2, 20, 'bfgs');
[history2,~] = ellipsoidfminunc(2, 20, 'dfp');
[history3,~] = ellipsoidfminunc(2, 20, 'steepdesc');


semilogy(history1.fcount, history1.fval, 'marker', 'd');
hold on;
semilogy(history2.fcount, history2.fval, 'marker', 'o');
semilogy(history3.fcount, history3.fval, 'marker', 'square', 'MarkerFaceColor','blue');
