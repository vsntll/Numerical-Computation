function x = gauss_jordan_no_pivot(A, b)
    A = double(A);
    b = double(b(:));
    n = size(A, 1);
    Aug = [A b];
    for i = 1:n
        pivot = Aug(i, i);
        if pivot == 0
            error('pivot is 0');
        end
        Aug(i, :) = Aug(i, :) / pivot; % Normalize the row

        for k = 1:n
            if i ~= k
                Aug(k, :) = Aug(k, :) - Aug(k, i) * Aug(i, :);
            end
        end
    end
    x = Aug(:, end);
end

% Example usage:
A = [2 1 3 4; 0 5 2 1; 0 0 7 6; 0 0 0 9];
b = [1; 2; 3; 4];
disp(gauss_jordan_no_pivot(A, b));
