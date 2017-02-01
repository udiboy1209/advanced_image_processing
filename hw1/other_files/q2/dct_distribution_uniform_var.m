function [integral] = dct_distribution_uniform_var(a,b,N,I)
    a = sqrt(a);
    b = sqrt(b);
    const = (1/(sqrt(2*pi)*(b-a)));
    s = a;
%     f_old = fn_to_integrate(s);
    delta_s = (b-a)/N;
    integral = 0;
    for i=1:N
        s = s + delta_s;
        f_new = fn_to_integrate(s,I);
        integral = integral + f_new * delta_s;
    end
    integral = integral * const;
end
