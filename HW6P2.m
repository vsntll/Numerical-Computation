
% Problem 2: Secant Method on f(x) = sign(x-a)*sqrt(|x-a|)
clc; clear; close all;

% Parameters
a = 0;
f = @(x) sign(x - a) .* sqrt(abs(x - a));

% Initial Guesses
x_prev = 1.0;
x_curr = 0.5;

% Array to store iteration values for plotting
x_history = [x_prev; x_curr];

% Display Header
fprintf('Iter\t x_k\t\t\t f(x_k)\n');
fprintf('-----------------------------------------\n');
fprintf('%d\t\t %.10f\t %.10f\n', 0, x_prev, f(x_prev));
fprintf('%d\t\t %.10f\t %.10f\n', 1, x_curr, f(x_curr));

% Secant Loop
max_iter = 19;
for k = 2:max_iter
    f_curr = f(x_curr);
    f_prev = f(x_prev);
    
    % Check for zero denominator to avoid crash
    if abs(f_curr - f_prev) < 1e-16
        fprintf('Difference in function values too small. Stopping.\n');
        break;
    end
    
    % Secant Update: x_{k+1} = x_k - f(x_k) * (x_k - x_{k-1}) / (f(x_k) - f(x_{k-1}))
    x_new = x_curr - f_curr * (x_curr - x_prev) / (f_curr - f_prev);
    
    % Print result
    fprintf('%d\t\t %.10f\t %.10f\n', k, x_new, f(x_new));
    
    % Store the new value
    x_history = [x_history; x_new];
    
    % Update for next iteration
    x_prev = x_curr;
    x_curr = x_new;
end

% Plot the behavior
figure;
iters = 0:(length(x_history)-1);
plot(iters, x_history, '-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');
title('Secant Method Convergence');
xlabel('Iteration (k)');
ylabel('x_k');
grid on;
