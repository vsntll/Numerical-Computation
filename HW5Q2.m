function [integral, samplingpoints] = adaptive_quad(f, a, b, tol)
    % Recursive adaptive quadrature using Simpson's rule
    
    % Initial calculation for the whole interval
    h = b - a;
    c = (a + b) / 2;
    fa = f(a);
    fb = f(b);
    fc = f(c);
    S1 = (h/6) * (fa + 4*fc + fb);
    
    % Call the recursive helper function
    [integral, samplingpoints] = recursive_quad(f, a, b, tol, S1, fa, fc, fb);
    % Collect the initial points
    samplingpoints = [samplingpoints, a, b, c];
end

function [Q, pts] = recursive_quad(f, a, b, tol, S, fa, fc, fb)
    h = b - a;
    c = (a + b) / 2;
    d = (a + c) / 2;
    e = (c + b) / 2;
    fd = f(d);
    fe = f(e);
    
    % Simpson's rule on left and right halves
    S_left = (h/12) * (fa + 4*fd + fc);
    S_right = (h/12) * (fc + 4*fe + fb);
    S2 = S_left + S_right;
    
    % Error estimate
    if abs(S2 - S) <= 15*tol
        Q = S2 + (S2 - S)/15; % More accurate result
        pts = [d, e]; % Return points evaluated at this level
    else
        [Q_left, pts_left] = recursive_quad(f, a, c, tol/2, S_left, fa, fd, fc);
        [Q_right, pts_right] = recursive_quad(f, c, b, tol/2, S_right, fc, fe, fb);
        Q = Q_left + Q_right;
        pts = [d, e, pts_left, pts_right];
    end
end

% Evaluate the three integrals
tolerances = [1e-3, 1e-6, 1e-9];

% (a) cos(x) from -1 to 1
fprintf('(a) Integral of cos(x) from -1 to 1\n');
for tol = tolerances
    [result_a, pts_a] = adaptive_quad(@cos, -1, 1, tol);
    exact_a = integral(@cos, -1, 1);
    fprintf('  Tol=%.0e: Result=%.12f, Exact=%.12f, Error=%.2e, Samples=%d\n', ...
        tol, result_a, exact_a, abs(result_a - exact_a), length(unique(round(pts_a, 10))));
end

% (b) 1/(1 + 100x^2) from -1 to 1
fprintf('(b) Integral of 1/(1+100x^2) from -1 to 1\n');
for tol = tolerances
    [result_b, pts_b] = adaptive_quad(@(x) 1./(1 + 100*x.^2), -1, 1, tol);
    exact_b = integral(@(x) 1./(1 + 100*x.^2), -1, 1);
    fprintf('  Tol=%.0e: Result=%.12f, Exact=%.12f, Error=%.2e, Samples=%d\n', ...
        tol, result_b, exact_b, abs(result_b - exact_b), length(unique(round(pts_b, 10))));
end

% (c) sqrt(|x|) from -1 to 1
fprintf('(c) Integral of sqrt(|x|) from -1 to 1\n');
for tol = tolerances
    [result_c, pts_c] = adaptive_quad(@(x) sqrt(abs(x)), -1, 1, tol);
    exact_c = integral(@(x) sqrt(abs(x)), -1, 1);
    fprintf('  Tol=%.0e: Result=%.12f, Exact=%.12f, Error=%.2e, Samples=%d\n', ...
        tol, result_c, exact_c, abs(result_c - exact_c), length(unique(round(pts_c, 10))));
end

% Plot sampling points for each integral
figure;
for i = 1:3
    subplot(1,3,i);
    integrands = {@cos, @(x) 1./(1 + 100*x.^2), @(x) sqrt(abs(x))};
    [~, pts] = adaptive_quad(integrands{i}, -1, 1, 1e-6);
    unique_pts = sort(unique(round(pts, 10)));
    f_vals = integrands{i}(unique_pts);
    scatter(unique_pts, f_vals, 20, 'filled');
    hold on;
    x_plot = linspace(-1, 1, 500);
    plot(x_plot, integrands{i}(x_plot), 'b-', 'LineWidth', 1.5);
    title(sprintf('Integral %s', char(96+i)));
    xlabel('x');
    ylabel('f(x)');
    grid on;
end
