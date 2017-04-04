function [W_fin,H_fin] = projected_grad_descent(Y,W_curr,H_curr)
    tic;
    step_size = 1e-6;
    
    lambda = 1;
%     cost_curr = cost_function(Y,W_curr,H_curr,lambda);
%     epsilon1 = 1e-2;
%     epsilon2 = 1e-2;
%     cost_prev = 0;
%     cost_new = inf;
%     iter = 0;
%     a1 = abs(cost_curr - cost_prev) > epsilon1;
%     b1 = abs(cost_curr) < epsilon2;
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
%             if (abs(cost_new) < abs(cost_curr))
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
    


%     while(abs(cost_curr - cost_prev) > epsilon1 || abs(cost_curr) > epsilon2)
% %         a1 = abs(cost_curr - cost_prev) > epsilon1;
% %         b1 = abs(cost_curr) > epsilon2;
%         cost_prev = cost_curr;
%         while(cost_new > cost_curr)
%             step_size = step_size/2;
%             %Fix H, update W
%             W_new_temp = W_curr + step_size*2*(Y - W_curr*H_curr)*H_curr';
%             W_new_temp(W_new_temp < 0) = 0;
%             W_new_temp = normc(W_new_temp);
%             %Fix W, update H
%             H_new_temp = H_curr + step_size*2*W_curr'*(Y - W_curr*H_curr);
%             H_new_temp(H_new_temp < 0) = 0;
%             cost_new = cost_function(Y,W_new_temp,H_new_temp,lambda);
%         end
%         
%         W_curr = W_new_temp;
%         H_curr = H_new_temp;
%         cost_curr = cost_function(Y,W_curr,H_curr,lambda);
%         iter = iter+1;
%         fprintf('Iteration %d\n',iter);
%         fprintf('Step size used %d\n',step_size);
%         fprintf('Cost Curr %f\n',cost_curr);
%         fprintf('Cost Reduction %f\n',cost_curr - cost_prev);       
%     end
    
    W_fin = W_curr;
    H_fin = H_curr;
    toc;
    
end
