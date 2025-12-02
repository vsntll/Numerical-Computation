x = [1 2 3 4 5];
y = [1 1 2 6 24];
p = polyfit(x, y, 4);

pp = spline(x, y);

xx = linspace(1, 5, 100);
poly_vals = polyval(p, xx);
spline_vals = ppval(pp, xx);
gamma_vals = gamma(xx);

figure(1);
plot(xx, poly_vals, 'r-', 'LineWidth', 2, 'DisplayName', 'Degree 4 Poly');
hold on;
plot(xx, spline_vals, 'b-', 'LineWidth', 2, 'DisplayName', 'Spline');
plot(xx, gamma_vals, 'k--', 'LineWidth', 2, 'DisplayName', 'Gamma Function');
scatter(x, y, 50, 'ko', 'filled', 'DisplayName', 'Data Points');
xlabel('x');
ylabel('y');
legend;
grid on;


poly_err = abs(gamma_vals - poly_vals);
spline_err = abs(gamma_vals - spline_vals);

figure(2);
semilogy(xx, poly_err, 'r-', 'LineWidth', 2, 'DisplayName', 'Poly Error');
hold on;
semilogy(xx, spline_err, 'b-', 'LineWidth', 2, 'DisplayName', 'Spline Error');
xlabel('x');
ylabel('Absolute Error');
legend;
grid on;
