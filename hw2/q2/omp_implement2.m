function [theta_out] = omp_implement2(Eu,A)
    y = Eu(:);
    [m,~] = size(A);
    A1 = normc(A);
    epsilon = 10^-3;
%     si = zeros(size(y));
    Ti = [];
    r = y;
    theta_out = zeros(size(A,2),1);
    iter = 0;
    while(norm(r) > epsilon && iter < m)
        t = (r' * A1);
        [~,ind] = max(t);
        Ti = [Ti, ind];
        At = A(:,Ti);
        s = pinv(At) * A1(:,ind);
        r = (y - At*s);
        iter = iter + 1;
    end
    
    theta_out(Ti) = s;
    
end
