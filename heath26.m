function cp02_06
    % Solve linear system with Hilbert matrix
    n = 1; condH = 1;
    disp(' n    resid_norm    error_norm    digits    cond')
    while condH < 1e16
        n = n + 1;
        H = hilb(n);
        condH = cond(H);
        x_true = ones(n,1);
        b = H * x_true;
        x = H\b;
        r_norm = norm(b - H*x, inf);
        e_norm = norm(x - x_true, inf);
        digits = -log10(e_norm);
        fprintf('%2d  %13.6e  %13.6e  %4.1f  %13.6e\n', n, r_norm, e_norm, digits, condH)
    end
    disp(' ')
    disp('Condition number is exponential in n.')
    disp('Number of correct digits is about 16 minus log_10 of condition number.')
end
