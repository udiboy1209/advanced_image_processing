function [grad] = grad_H(Y,W,H,lambda)
    wh = W*H;
    y_by_wh = Y./wh;
    one_y_by_wh = 1 - y_by_wh;
    grad = W'*one_y_by_wh + lambda;
end
