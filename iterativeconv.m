function [x, iterations] = recip(b, x0, tol)
    x = x0;
    iterations = 0;
    while true
        x_new = x * (2 - b * x);
        iterations = iterations + 1;
        if abs(x_new - x) < tol
            x = x_new;
            break;
        end
        x = x_new;
    end
end

% Params
b = pi;
tol = 1e-10;

% Initial guess 1
x0_1 = 1;
[x0, it1] = recip(b, x0_1, tol);

% Initial guess 2
x0_2 = 0.1;
[x2, it2] = recip(b, x0_2, tol);

% Display
fprintf('Initial guess x0=1: Approx 1/pi = %.12f, Iterations = %d\n', x1, it1);
fprintf('Initial guess x0=0.1: Approx 1/pi = %.12f, Iterations = %d\n', x2, it2);
