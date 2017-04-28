function [I_A] = get_Ia(u1 ,u2, alpha)
    diff = -255:1:255;
    N = length(diff);
    M = (N+1)/2;
%     %p is of length N, M->0 
    max_val = 1 - alpha;
    p = zeros(size(diff));
    
    [N,C] = size(u1);
    I_A = zeros(N,C);
    
    for c = 1:C
        for j = 1:N
            for i = 1:length(diff)
                p(i) = exp(-u1(j,c)-u2(j,c))*(u1(j,c)/u2(j,c))^(diff(i)/2)*besseli(abs(diff(i)),2*sqrt(u1(j,c)*u2(j,c)));
            end

            F = cumsum(p);
            out_id = 1;
            for i1 = 1:M-1
                if (F(M+i1) - F(M-i1) < max_val)
                    out_id = diff(M+i1);
                end
            end

            I_A(j,c) = out_id;
    %         figure;
    %         plot(diff,p);
    %         hold on;
    %         plot(diff,F);
    %         hold off;
        end
    end
   
end
