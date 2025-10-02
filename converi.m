g1 = @(x) (x.^2 + 2) / 3;
g2 = @(x) sqrt(3 * x - 2);
g3 = @(x) 3 - (2 ./ x);
g4 = @(x) (x.^2 - 2) ./ (2 * x - 3);

gs = {g1, g2, g3, g4};
labels = {'g1', 'g2', 'g3', 'g4'};

x0 = 1.99;       % Closer initial guess to root 2 to help convergence
N = 50;          % Max iterations
tol = 1e-8;      % Convergence tolerance

for j = 1:length(gs)
    x_last = x0;
    converged = false;
    fprintf('\n%s(x):\n', labels{j});
    for i = 1:N
        % Domain check for g2
        if strcmp(labels{j}, 'g2') && (3*x_last - 2) < 0
            fprintf('Out of domain for sqrt at iteration %d\n', i);
            break;
        end
        % Division by zero checks for g3 and g4
        if strcmp(labels{j}, 'g3') && abs(x_last) < eps
            fprintf('Division by zero at iteration %d\n', i);
            break;
        end
        if strcmp(labels{j}, 'g4') && abs(2*x_last - 3) < eps
            fprintf('Division by zero at iteration %d\n', i);
            break;
        end

        x_next = gs{j}(x_last);

        if ~isreal(x_next)
            fprintf('Non-real value at iteration %d\n', i);
            break;
        end

        diff = abs(x_next - x_last);
        fprintf('Iter %2d: x = %.12f, diff = %.2e\n', i, x_next, diff);

        if diff < tol
            fprintf('Converged to %.12f after %d iterations.\n', x_next, i);
            converged = true;
            break;
        end

        if abs(x_next) > 1e10
            fprintf('Diverging at iteration %d\n', i);
            break;
        end

        x_last = x_next;
    end

    if ~converged
        fprintf('Did not converge in %d iterations.\n', N);
    end
end
