function [theta] = ista(y, A,lambda, alpha, initial_theta)
    theta_k = initial_theta;
    epsilon = 10^-3;
    theta_kp1 = soft(theta_k + A'*(y-A*theta_k)/alpha, lambda/(2*alpha));
    while(norm(theta_kp1 - theta_k) >= epsilon)
        theta_k = theta_kp1;
        theta_kp1 = soft(theta_k + A'*(y-A*theta_k)/alpha, lambda/(2*alpha)); 
    end
    theta = theta_kp1;
end