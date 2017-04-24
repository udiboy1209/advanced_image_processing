function [out_id] = get_Ia(u1,u2,alpha)
    diff = -255:1:255;
    N = length(diff);
    M = (N+1)/2;
    %p is of length N, M->0 
    max_val = 1 - alpha;
    p = exp(-u1-u2)*(u1/u2)^(diff/2)*besseli(abs(diff),2*sqrt(u1*u2));
    out_id = 1;
    for i1 = 1:M
        if (p(M-i1) - p(M+i1) < max_val)
            out_id = i1;
        end
    end
end
