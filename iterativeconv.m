function [x, iterations] = recip(b, x0, tol)
    max_iters = 1000;
    x = x0;
    iterations = 0;

    while true
        x_new = x * (2 - b * x);
        iterations = iterations + 1;

        if isnan(x_new) || isinf(x_new) || abs(x_new) > 1e5
            fprintf('Divergence detected starting from x0 = %.2f, terminating iteration.\n', x0);
            x = NaN;
            break;
        end

        if abs(x_new - x) < tol || iterations >= max_iters
            x = x_new;
            break;
        end

        x = x_new;
    end

    if iterations == max_iters
        fprintf('Max iterations reached without convergence.\n');
    end
end


b = pi;
tol = 1e-10;

x0_1 = 1;
[x1, it1] = recip(b, x0_1, tol);

x0_2 = 0.1;
[x2, it2] = recip(b, x0_2, tol);

fprintf('x0 = 1: Approx 1/pi = %.12f, Iterations = %d\n', x1, it1);
fprintf('x0 = 0.1: Approx 1/pi = %.12f, Iterations = %d\n', x2, it2);
