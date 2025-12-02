function [integral, n_evals] = simpson_composite(f, a, b, tol)
    % Composite Simpson's rule with adaptive refinement
    
    % Start with n=2 intervals (3 points)
    n = 2;
    h = (b - a) / n;
    x = a:h:b;
    y = f(x);
    n_evals = n + 1;
    S_old = h/3 * (y(1) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-1)) + y(end));
    
    while true
        n = 2*n;
        h = (b - a) / n;
        x = a:h:b;
        y = f(x);
        n_evals = n_evals + n + 1;
        
        % Compute new Simpson's approximation
        S_new = h/3 * (y(1) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-1)) + y(end));
        
        % Error estimate using Richardson extrapolation
        error = abs(S_new - S_old) / 15;
        
        if error < tol
            integral = S_new;
            return
        end
        S_old = S_new;
    end
end

% Main computation
f = @(x) sin(x);
a = 0; b = pi;
tol = 1e-6;

[integral_sim, n_evals] = simpson_composite(f, a, b, tol);
integral_exact = integral(@(x) sin(x), 0, pi);  % Using MATLAB's quad

fprintf('Simpson''s Result: %.12f\n', integral_sim);
fprintf('Exact (quad):     %.12f\n', integral_exact);
fprintf('Error: %.2e\n', abs(integral_sim - integral_exact));
fprintf('Function evaluations: %d\n', n_evals);
