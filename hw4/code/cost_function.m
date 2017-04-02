function [cost] = cost_function(Y,W,H,lambda)
    cost = 0;
    [n,N] = size(Y);
    wh = W*H;
    for k = 1:N
        w_hk = wh(:,k);
        for l = 1:n
            cost = cost - Y(l,k)*log(w_hk(l)) + w_hk(l);
        end
    end
    
    cost = cost + lambda * sum(sum(H));
end
