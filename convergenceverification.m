% Fixed-point functions
g1 = @(x) (x.^2 + 2)/3;
g2 = @(x) sqrt(3*x - 2);
g3 = @(x) (3 - 2*x) ./ x;
g4 = @(x) (x.^2 - 2) ./ (2*x - 3);

g = {g1, g2, g3, g4};
names = {'g1', 'g2', 'g3', 'g4'};

% Parameters
tol = 1e-8;
maxIter = 50;
x0 = 1.8;     % Initial guess close to x=2
true_root = 2;

for i = 1:4
    x = x0;
    fprintf('\n%s(x):\n', names{i});
    fprintf('Iter\t   x_n\t\t   error\n');
    for k = 1:maxIter
        x_new = g{i}(x);
        err = abs(x_new - true_root);
        fprintf('%2d\t%.8f\t%.2e\n', k, x_new, err);
        if isnan(x_new) || isinf(x_new)
            fprintf('Diverged (NaN or inf encountered)\n');
            break;
        end
        if err < tol
            fprintf('Converged to %.8f in %d iterations\n', x_new, k);
            break;
        end
        x = x_new;
    end
    if k == maxIter
        fprintf('Did not converge within %d iterations.\n', maxIter);
    end
end
