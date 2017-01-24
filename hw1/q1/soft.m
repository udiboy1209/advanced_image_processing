function [x] = soft(y,lambda)
    g = y >= lambda;
    l = y <= -lambda;
    x = (y - g*lambda + l*lambda).*(g+l); 
end