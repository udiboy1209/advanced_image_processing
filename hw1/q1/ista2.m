function [x,J] = ista2(y,A,lambda,alpha,Nit)
    J = zeros(1,Nit);
    x = zeros(size(A'*y));
    T = lambda / (2*alpha);
    for k = 1:Nit
        Ax = A * x;
        J(k) = norm(Ax - y).^2 + lambda*norm(x,1);
        x = soft(x + A'*(y - Ax)/alpha,T);
    end
end
