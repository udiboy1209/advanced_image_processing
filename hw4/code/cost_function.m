function [cost] = cost_function(Y,W,H,lambda)
    cost = 0;
    wh = W*H;
    wh_log = log(wh);
    cost = cost - sum(sum(Y.*wh_log)) + sum(sum(wh));
    cost = cost + lambda * sum(sum(H));
end
