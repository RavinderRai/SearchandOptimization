
[history1,~] = rastriginfminunc(2, 30, 'bfgs');
[history2,~] = rastriginfminunc(2, 30, 'dfp');
[history3,~] = rastriginfminunc(2, 30, 'steepdesc');


semilogy(history1.fcount, history1.fval, 'marker', 'd');
hold on;
semilogy(history2.fcount, history2.fval, 'marker', 'o');
semilogy(history3.fcount, history3.fval, 'marker', 'square', 'MarkerFaceColor','blue');
