function [std_two_pass, std_one_pass] = my_std(x)
    n = length(x);
    mean_x = mean(x);

    % Two-pass formula
    sum_sq = sum((x - mean_x).^2);
    std_two_pass = sqrt(sum_sq / (n-1));

    % One-pass formula
    sum_x = sum(x);
    sum_x2 = sum(x.^2);
    std_one_pass = sqrt((sum_x2 - (sum_x^2)/n)/(n-1));
end

x = [1, 2, 3, 4, 5];
[tp, op] = my_std(x);
disp(['Two-pass: ', num2str(tp)]);    % Output: Two-pass: 1.5811
disp(['One-pass: ', num2str(op)]);    % Output: One-pass: 1.5811

x = [1e8+3, 1e8+2, 1e8+1, 1e8, 1e8-1, 1e8-2, 1e8-3];
[tp, op] = my_std(x);
disp(['Two-pass: ', num2str(tp)]);   % Output: Two-pass: 2.1602
disp(['One-pass: ', num2str(op)]);   % Output: One-pass: 2

% The one-pass formula returns 2 and loses significant digits while the two-pass formula returns 2.1602 and remains accurate. This is due to numerical instability in the one-pass formula when dealing with large numbers.


x = 0.05;
n = [1 10 100 1000 1e4 1e5 1e6 1e7 1e8 1e9 1e10 1e11 1e12 1e13 1e14 1e15];
for i = 1:length(n)
   Inx(i) = (1 + x./n(i)).^n(i);
end
format long e
table = [n.' Inx.'];
disp(table)
disp(['exp(0.05) = ', num2str(exp(0.05), 16)])
