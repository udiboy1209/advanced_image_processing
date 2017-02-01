function [f] = fn_to_integrate(s,I)
    f = (1/sqrt(s))*exp(-I.^2/s);
%     f = I.^2 * s^2;
end
