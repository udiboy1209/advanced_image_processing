function [theta_out,iter] = omp_implement2(Eu,A, epsilon)
    y = Eu(:);
    [m,n] = size(A);
    norm_of_colA = zeros(1,n);
    for i=1:n
        norm_of_colA(1,i) = norm(A(:,i));
    end
    
%     epsilon1 = 1e-4;
    
%     s = zeros(n,1);
    theta_out = zeros(n,1);
    Ti = [];
    iter = 0;
    r = y;
    while(norm(r,2)^2 > epsilon)
        iter = iter + 1;
        t = (A' * r);
        t = t./norm_of_colA(:).^2;
        [~,ind] = max(t);
        Ti = [Ti ind];
        At = A(:,Ti);
        s1 = pinv(At) * y;
        r = y - At*s1;
    end
    
    theta_out(Ti) = s1;
    
    
%     y = Eu(:);
%     [m,n] = size(A);
% %     A1 = normc(A);
%     norm_of_colA = zeros(1,n);
%     for i=1:n
%         norm_of_colA(1,i) = norm(A(:,i));
%     end
%     
%     epsilon = 10^-3;
% %     si = zeros(size(y));
%     Ti = [];
%     r = y;
%     theta_out = zeros(size(A,2),1);
%     iter = 0;
%     s = zeros(n,1);
%     while(norm(r) > epsilon && iter < m)
%         t = (r' * A);
%         t = t./norm_of_colA;
%         [~,ind] = max(t);
%         Ti = [Ti ind];
%         At = A(:,Ti);
%         s1 = pinv(At) * A(:,ind);
%         s(Ti) = s1;
%         r = (y - A*s);
%         iter = iter + 1;
%     end
%     
%     theta_out = s;
%     
end
