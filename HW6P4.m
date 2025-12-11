% Problem 4: SIR Model using ode45
clc; clear; close all;

% Parameters
c = 1;  % Infection rate
d = 5;  % Removal rate

% Time span and Initial Conditions
tspan = [0 1];
y0 = [95; 5; 0]; % [Susceptible; Infective; Removed]

% Define ODE system function nested or as a handle
% y(1) = Susceptible, y(2) = Infective, y(3) = Removed
ode_system = @(t, y) [ -c * y(1) * y(2);            % y1'
                        c * y(1) * y(2) - d * y(2); % y2'
                        d * y(2) ];                 % y3'

% Solve using ode45 (Runge-Kutta)
[t, y] = ode45(ode_system, tspan, y0);

% Plotting
figure;
plot(t, y(:,1), 'b-', 'LineWidth', 2); hold on;
plot(t, y(:,2), 'r-', 'LineWidth', 2);
plot(t, y(:,3), 'g-', 'LineWidth', 2);

title(['SIR Model (c=', num2str(c), ', d=', num2str(d), ')']);
xlabel('Time t');
ylabel('Population');
legend('Susceptible (y_1)', 'Infective (y_2)', 'Removed (y_3)');
grid on;

% Display final values
fprintf('Final Populations at t=1:\n');
fprintf('Susceptibles: %.4f\n', y(end, 1));
fprintf('Infectives:   %.4f\n', y(end, 2));
fprintf('Removed:      %.4f\n', y(end, 3));
