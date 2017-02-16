function [aj,ind] = choose_max_aj_similar(r,A)
    [~,ind] = max(r' * A);
    aj = A(:,ind);
end
