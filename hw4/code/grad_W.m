function [grad] = grad_W(Y,W,H)
    wh = W*H;
    y_by_wh = Y./wh;
    one_y_by_wh = 1 - y_by_wh;
    grad = one_y_by_wh*H';
end
