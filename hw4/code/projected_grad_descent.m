function [W_fin,H_fin] = projected_grad_descent(Y,W_curr,H_curr)
    tic;
    step_size = 1e-1;
%     step_size = 2;
    
    lambda = 20;

    for iter=1:200
        cost_curr = cost_function(Y,W_curr,H_curr,lambda);
        while(1)
            deriv_W = grad_W(Y,W_curr,H_curr);
            W_new_temp = W_curr - step_size * deriv_W;
            W_new_temp(W_new_temp < 0) = 0;
            W_new_temp = normc(W_new_temp);
            deriv_H = grad_H(Y,W_new_temp,H_curr,lambda);
            H_new_temp = H_curr - step_size * deriv_H;
            H_new_temp(H_new_temp < 0) = 0;
            cost_new = cost_function(Y,W_new_temp,H_new_temp,lambda);
            if (cost_new < cost_curr)
                W_curr = W_new_temp;
                H_curr = H_new_temp;
                step_size = step_size*1.1;
                break;
            else
                step_size = step_size/2;
            end
        end
        fprintf('Iteration %d\n',iter);
        fprintf('Step size used %d\n',step_size);
        fprintf('Cost Curr %f\n',cost_curr);
        fprintf('Cost new %f\n', cost_new);
        fprintf('Cost Reduction %f\n',cost_new - cost_curr);     
        
    end
    
    W_fin = W_curr;
    H_fin = H_curr;
    toc;    
end
