% Implement Bisection, Newton, and Secant methods in 1 dimension.
% Test your implementations for each of the following equations and find at least 1 root.

% 1. x^3 - 2x - 5 = 0
fa = @(x) x.^3 - 2*x -6;    % original
dfa = @(x) 3*x.^2 -2;       % derivative
% 2. e ^-x  = x
fb = @(x) exp(x) - x;   % original
dfa= @(x) exp(x) - 1;   % derivative
% 3. xsin(x) =1 
fc = @(x) x * sin(x) - 1; 
dfx= @(x) sin(x) + x*cos(x);
% 4. x^3 - 3x^2 + 3x - 1 = 0
fd = @(x) x.^3 - 3*x.^2 + 3*x -1;
dfd = @(x) 3*x.^2 - 6*x +3;


% Bisection method
% Inputs:
%   f - function handle
%   a, b - interval endpoints where f(a)*f(b)<0
% Output:
%   root - root of function within tolerance
function root = bisection(f, a, b)
    tol = 1e-8;             % Tolerance for convergence
    fa = f(a);              
    fb = f(b);
    if fa * fb > 0
        error('Function has same sign at endpoints.');
    end
    % Iteratively narrow the interval by checking midpoint sign
    while abs(b - a) > tol
        m = (a + b) / 2;
        fm = f(m);
        if abs(fm) < tol     % Stop if function value close to zero
            root = m;
            return
        end
        % Choose subinterval containing root
        if fa * fm < 0
            b = m; fb = fm;
        else
            a = m; fa = fm;
        end
    end
    root = (a + b) / 2;     % Return midpoint as approximate root
end

% Newton's method function
% Inputs:
%   f - function handle
%   df - derivative function handle
%   x0 - initial guess
% Output:
%   root - approximated root after iterations
function root = newton(f, df, x0)
    tol = 1e-8;             % Tolerance for convergence
    max_iter = 100;         % Maximum number of iterations allowed
    x = x0;                 % Current approximation
for k = 1:max_iter
        fx = f(x);
        dfx = df(x);
        if abs(dfx) < 1e-14 % Avoid division by very small derivative
            root = x;
            return
        end
        x_new = x - fx / dfx; % Newton update step
        if abs(x_new - x) < tol || abs(fx) < tol % Check convergence
            root = x_new;
            return
        end
        x = x_new;           % Update current estimate
    end
    root = x;               % Return last estimate if max iterations reached
end

% Secant method function
% Inputs:
%   f - function handle
%   x0, x1 - initial two approximations
% Output:
%   root - approximated root using secant iterations
function root = secant(f, x0, x1)
    tol = 1e-8;             % Tolerance
    max_iter = 100;         % Maximum iterations
    for k = 1:max_iter
        f0 = f(x0);
        f1 = f(x1);
        if abs(f1 - f0) < 1e-14 % Prevent division by small number
            root = x1;
            return
        end
        % Compute next root estimate using secant formula
        x2 = x1 - f1 * (x1 - x0) / (f1 - f0);
        % Convergence check by difference or function value
        if abs(x2 - x1) < tol || abs(f(x2)) < tol
            root = x2;
            return
        end
        x0 = x1;              % Update values for next iteration
        x1 = x2;
    end
    root = x1;                % Return last estimate on max iteration
end


% Run all methods for each eq
results = struct();

% Eq 1: root search interval [2,3] for bisection & secant; intial guess of 2.5 for Newton's
results.a_bisection = bisection(fa, 2, 3);
results.a_newton = newton(fa, dfa, 2.5);
results.a_secant = secant(fa, 2, 3);

% Eq 2: bisection should error out~
results.b_bisection = bisection(fb, 0, 1);
results.b_newton = newton(fb, dfb, 0.5)
results.b_secant = secant(fb, 0, 1);

% Eq 3: root in [1,2]
results.c_bisection = bisection(fd, 1, 2);
results.c_newton = newton(fd, dfd, 1.5);
results.c_secant = secant(fd, 1, 2);

% Eq 4: root in [0, 1]
results.d_bisetion = bisection(fd, 0, 1);
results.d_newton = newton(fd, dfd, 0.5);
results.d_secant = secant(fd, 0, 1);

% Display
disp('Roots found for each method & Equation')
disp(results)


