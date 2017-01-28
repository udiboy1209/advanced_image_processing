function [theta,J] = ista(y, A,lambda, alpha, initial_theta)
    theta_k = initial_theta;
%     epsilon = 10^-10;
    epsilon = 1;
    soft_in = theta_k + A'*(y-A*theta_k)/alpha;
    lambda_in = lambda/(2*alpha);
    theta_kp1 = soft(soft_in, lambda_in);
    count = 0;
    while(norm(theta_kp1 - theta_k) >= epsilon)
        count = count + 1;
        J(count) = norm(y-A*theta_k).^2 + lambda*norm(theta_k,1)/(2*alpha);
        theta_k = theta_kp1;
        soft_in = theta_k + A'*(y-A*theta_k)/alpha;
        theta_kp1 = soft(soft_in, lambda_in);
%         theta_kp1 = soft(theta_k + A'*(y-A*theta_k)/alpha, lambda/(2*alpha)); 
    end
    theta = theta_kp1;
end