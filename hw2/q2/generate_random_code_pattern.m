function [Ct] = generate_random_code_pattern(H,W,T)
    Ct = randi([0 1],H*W*T,1);
end
