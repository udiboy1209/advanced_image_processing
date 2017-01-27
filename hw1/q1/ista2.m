function [x,J, it] = ista2(y,A,lambda,alpha,Nit)
    J = zeros(1,Nit);
    x = zeros(size(A'*y));
    T = lambda / (2*alpha);
    k = 0;
    prev_error = inf;
    error = norm(A*x - y).^2 + lambda*norm(x,1);
    epsilon = 10^-10;
    while (abs(error-prev_error) > epsilon)
        Ax = A * x;
        k = k + 1;
        prev_error = error;
        x = soft(x + A'*(y - Ax)/alpha,T);
        error = norm(Ax - y).^2 + lambda*norm(x,1);
        J(k) = error;
        
    end
    it = k;
end
