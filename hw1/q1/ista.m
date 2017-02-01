function [theta,count] = ista(y, A,lambda, alpha, initial_theta, epsilon)
    theta_k = initial_theta;
    soft_in = theta_k + A'*(y-A*theta_k)/alpha;
    lambda_in = lambda/(2*alpha);
    theta_kp1 = soft(soft_in, lambda_in);
    count = 0;
    while(norm(theta_kp1 - theta_k) >= epsilon)
        count = count + 1;
        theta_k = theta_kp1;
        soft_in = theta_k + A'*(y-A*theta_k)/alpha;
        theta_kp1 = soft(soft_in, lambda_in);
    end
    theta = theta_kp1;
end