% How many zeroes does the function
% f(x) = sin(10x) - x have?

% Function: Zero-finding routine


f = @(x) sin(10*x) - x;

% Define interval to search roots
x_min = 0;
x_max = 3;

% Discretize interval with small step to find sign changes
x_vals = linspace(x_min, x_max, 1000);
f_vals = f(x_vals);


% essentially using simpler bisection method which follows IVT erm... yeah
% using this guarantees convergence to a root
roots_found = [];
for i = 1:length(x_vals)-1
    if sign(f_vals(i)) * sign(f_vals(i+1)) < 0
        % Interval brackets a root, use fzero to find root
        a = x_vals(i);
        b = x_vals(i+1);
        root = fzero(f, [a, b]);
        roots_found = [roots_found; root];
    end
end

% Remove duplicates (roots close within tolerance)
roots_found = unique(round(roots_found, 8));

disp('Roots of sin(10x) - x found:')
disp(roots_found)
