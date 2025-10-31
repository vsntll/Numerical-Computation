Multiple ways to find the roots without using methods:

Polynomical roots finder
x = roots(p)
p = [-1 , 5, 6, -3]; -> -x^3 + 5x^2 + 6x -3


x = fzero(function, x0)
function = function
x0 = initial guess / interval

Systems of nonlinear equations
x = fsolve(f, x0)
f = function handle, vector if a system
x0 = initial guess vector