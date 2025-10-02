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
