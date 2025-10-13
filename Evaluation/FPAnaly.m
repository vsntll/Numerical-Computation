% Function : f(x) = (((x-0.5) + x) + 0.5) + x
% Is there any floating point value x such that f(x) is exactly 0?
% IF zero-finding routine is used, what is the value of f
% Experiment with error tolerance

% Rough Reason: Precision and tolerance

% Define the function fx = sqrt(x) - sqrt(x) evaluated without simplification
f = @(x) sqrt(x) - sqrt(x);

% Interval containing root candidate (e.g., between 0 and 1)
a = 0.1; b = 2; % example bracket

% Example: Bisection method adapted for the function
tol_values = [1e-3, 1e-6, 1e-9, 1e-12, 1e-15];
roots = zeros(size(tol_values));
fvals = zeros(size(tol_values));

for i = 1:length(tol_values)
    tol = tol_values(i);
    % Bisection to find root (modification to break early if f(m) is zero)
    root = bisection_custom(f, a, b, tol);
    roots(i) = root;
    fvals(i) = f(root);
end

fprintf('Tolerance\tRoot\t\tf(root)\n');
for i = 1:length(tol_values)
    fprintf('%e\t%e\t%e\n', tol_values(i), roots(i), fvals(i));
end

% Custom Bisection function for demonstration
function root = bisection_custom(f, a, b, tol)
    fa = f(a);
    fb = f(b);
    if sign(fa) * sign(fb) > 0
        error('Function has same sign at interval endpoints.');
    end
    while abs(b - a) > tol
        m = (a + b)/2;
        fm = f(m);
        if fm == 0 || abs(b - a) < tol
            root = m;
            return;
        end
        if sign(fm) == sign(fa)
            a = m;
            fa = fm;
        else
            b = m;
            fb = fm;
        end
    end
    root = (a + b)/2;
end
