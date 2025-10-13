function x = nth_root_newton(y, n, x0, tol, max_iter)
% nth_root_newton - Compute the nth root of y using Newton's method
%
% This function solves the nonlinear equation f(x) = x^n - y = 0 for x
% using Newton's method. It works for both real and complex roots.
%
% Inputs:
%   y        - The number whose nth root is to be computed (can be complex)
%   n        - The root to compute (positive integer)
%   x0       - Initial guess (can be complex)
%   tol      - Convergence tolerance (optional, default = 1e-12)
%   max_iter - Maximum number of iterations (optional, default = 100)
%
% Output:
%   x        - Approximate nth root of y
%
% Newton's method iteration:
%   x_{k+1} = x_k - f(x_k)/f'(x_k)
%   where f(x) = x^n - y and f'(x) = n*x^{n-1}
%   
%   This gives: x_{k+1} = (1/n) * ((n-1)*x_k + y/x_k^{n-1})

    if nargin < 4
        tol = 1e-12;
    end
    if nargin < 5
        max_iter = 100;
    end
    
    x = x0;
    
    for k = 1:max_iter
        fx = x^n - y;
        if abs(fx) < tol
            fprintf('Converged in %d iterations\n', k);
            return;
        end
        
        fpx = n * x^(n-1);
        if abs(fpx) < eps
            error('Derivative too small - Newton method may not converge');
        end
        
        x_new = x - fx/fpx;
        
        if abs(x_new - x) < tol
            fprintf('Converged in %d iterations\n', k);
            x = x_new;
            return;
        end
        
        x = x_new;
    end
    
    warning('Maximum iterations reached without convergence');
end

% Test the function with the specified example
fprintf('Testing nth_root_newton function:\n');
fprintf('Computing complex cube root of 3 in upper-left quadrant\n');
fprintf('Using initial guess x0 = -1 + i\n\n');

y = 3;          
n = 3;          
x0 = -1 + 1i;   

x_result = nth_root_newton(y, n, x0);

fprintf('Result: x = %.6f + %.6fi\n', real(x_result), imag(x_result));
fprintf('Verification: x^3 = %.6f + %.6fi\n', real(x_result^3), imag(x_result^3));
fprintf('Error: |x^3 - 3| = %.2e\n', abs(x_result^3 - 3));

% Display all three cube roots of 3
fprintf('\nAll three cube roots of 3:\n');
theta = 2*pi/3;
for k = 0:2
    root_k = 3^(1/3) * exp(1i * k * theta);
    fprintf('Root %d: %.6f + %.6fi\n', k+1, real(root_k), imag(root_k));
end

fprintf('\nOur computed root is in quadrant: ');
if real(x_result) < 0 && imag(x_result) > 0
    fprintf('Upper-left (correct)\n');
else
    fprintf('Incorrect quadrant\n');
end
