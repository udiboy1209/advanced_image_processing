function [W_fin,H_fin] = projected_grad_descent(Y,W_curr,H_curr)
    tic;
    step_size = 1;
    cost_prev = 0;
    lambda = 1;
    cost_curr = cost_function(Y,W_curr,H_curr,lambda);
    epsilon = 1;
    while(abs(cost_curr - cost_prev) > epsilon)
        cost_prev = cost_curr;
        
        
        %Fix H, update W
        W_new_temp = W_curr + step_size*2*(Y - W_curr*H_curr)*H_curr';
        cost_new = cost_function(Y,W_new_temp,H_curr,lambda);
        while(cost_new > cost_curr)
            step_size = step_size/2;
            W_new_temp = W_curr + step_size*2*(Y - W_curr*H_curr)*H_curr';
            cost_new = cost_function(Y,W_new_temp,H_curr,lambda);
        end
        W_new_temp(W_new_temp < 0) = 0;
        W_curr = normc(W_new_temp);
        cost_curr = cost_function(Y,W_curr,H_curr,lambda);
        
        
        %Fix W, update H
        H_new_temp = H_curr + step_size*2*W_curr'*(Y - W_curr*H_curr);
        cost_new = cost_function(Y,W_curr,H_new_temp,lambda);
        while(cost_new > cost_curr)
            step_size = step_size/2;
            H_new_temp = H_curr + step_size*2*W_curr'*(Y - W_curr*H_curr);
            cost_new = cost_function(Y,W_curr,H_new_temp,lambda);            
        end
        H_new_temp(H_new_temp < 0) = 0;
        H_curr = H_new_temp;
        cost_curr = cost_function(Y,W_curr,H_curr,lambda);
    end
    
    W_fin = W_curr;
    H_fin = H_curr;
    toc;
    
end
