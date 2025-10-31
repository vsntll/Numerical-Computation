% (a) x^3 - 2x - 5 = 0
x0 = 1;  % Example starting point
f = @(x) x^3 - 2*x - 5;
df = @(x) 3*x^2 - 2;
x1 = x0 - f(x0)/df(x0);
disp(['Eq (a): ', num2str(x1)]);

% (b) e^{-x} = x
x0 = 1;  % Example starting point
f = @(x) exp(-x) - x;
df = @(x) -exp(-x) - 1;
x1 = x0 - f(x0)/df(x0);
disp(['Eq (b): ', num2str(x1)]);

% (c) x*sin(x) = 1
x0 = 1;  % Example starting point
f = @(x) x*sin(x) - 1;
df = @(x) sin(x) + x*cos(x);
x1 = x0 - f(x0)/df(x0);
disp(['Eq (c): ', num2str(x1)]);
