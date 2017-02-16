function [theta_out] = omp_implement2(Eu,A)
    y = Eu(:);
    [m,n] = size(A);
    A1 = A;
    norm_cols = zeros(1,n);
    for col=1:n
        norm_cols(col) = norm(A(:,col));
    end
    
%     A1 = normc(A);
    epsilon = 10^-3;
%     si = zeros(size(y));
    Ti = [];
    r = y;
    theta_out = zeros(size(A,2),1);
    iter = 0;
    while(norm(r) > epsilon && iter < m)
        t = (r' * A1);
        t1 = t./norm_cols;
        [~,ind] = max(t1);
        Ti = [Ti ind];
        At = A(:,Ti);
        s = pinv(At) * A1(:,ind);
        r = (y - At*s);
        iter = iter + 1;
        if(iter > 110)
            disp('yp');
        end
    end
    
    theta_out(Ti) = s;
    
end
