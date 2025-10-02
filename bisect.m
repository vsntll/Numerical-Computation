function [p,n] = bisection(func,a,b,fa,fb,atol)
% function [p,n] = bisect(func,a,b,fa,fb,atol)
%
% Assuming fa = func(a), fb = func(b), and fa*fb < 0,
% there is a value root in (a,b) such that func(root) = 0.
% This function returns in p a value such that
%    | p - root | < atol
% and in n the number of iterations required.

% check input
if (a >= b) || (fa*fb >= 0) || (atol <= 0)
    disp('something wrong with the input: quitting');
    p = NaN; n=NaN;
    return
end

n = ceil( log2(b-a) - log2(2*atol) );
for k=1:n
    p = (a+b)/2;
    fp = feval(func,p);
    if fa * fp < 0
        b = p;
        fb = fp;
    else
        a = p;
        fa = fp;
    end
end
p = (a+b)/2;
end

% Function definitionm
func = @(x) sqrt(x) - 1.1;

% Interval endpoints
a = 0;
b = 2;

% Function values at interval endpoints;
fa = func(a);
fb = func(b);

% Absolute tolerance
atol = 1e-8;

% Bisect call 
[p,n] = bisection(func, a, b, fa, fb , atol);

troot = 1.21; 
abs_error = abs(p-troot);

% Display results
fprintf('Root approximation: %.12f\n', p);
fprintf('Number of iterations: %d\n', n);
fprintf('Absolute error: %.2e\n', abs_error);

abs_error_bound = (b - a)/2^n;
fprintf('Error bound from bisection: %.2e\n', abs_error_bound)
