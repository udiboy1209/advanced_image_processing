function [out_id] = get_Ia(u1 ,u2, alpha)
    diff = -255:1:255;
    N = length(diff);
    M = (N+1)/2;
%     %p is of length N, M->0 
    max_val = 1 - alpha;
    p = zeros(size(diff));
    for i = 1:length(diff)
        p(i) = exp(-u1-u2)*(u1/u1)^(diff(i)/2)*besseli(abs(diff(i)),2*sqrt(u1*u2));
    end
    
    F = cumsum(p);
    out_id = 1;
    for i1 = 1:M-1
        if (F(M-i1) - F(M+i1) < max_val)
            out_id = i1;
        end
    end
    figure;
    plot(diff,p);
    hold on;
    plot(diff,F);
    hold off;
   
end
