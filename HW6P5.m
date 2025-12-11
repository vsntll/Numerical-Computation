% Problem 5: Forward and Backward Euler
clc; clear;

% Parameters
y0 = 1;
h = 1;
% ODE: y' = -3y

fprintf('Initial State: y(0) = %.1f, Step size h = %.1f\n', y0, h);
fprintf('--------------------------------------------\n');

% 1. Forward Euler
% y_{n+1} = y_n + h * f(t, y_n)
% y_1 = y_0 + h * (-3 * y_0)
y_forward = y0 + h * (-3 * y0);
fprintf('Forward Euler result:  %.4f\n', y_forward);

% 2. Backward Euler
% y_{n+1} = y_n + h * f(t, y_{n+1})
% y_1 = y_0 + h * (-3 * y_1)
% y_1 = y_0 / (1 + 3h)
y_backward = y0 / (1 + 3 * h);
fprintf('Backward Euler result: %.4f\n', y_backward);
