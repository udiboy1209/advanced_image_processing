function [x] = create_random_sparse_vector()
    x = zeros(1,100);
    for i = 1:10
        k = uint8(1 + rand * 100);
        x(k) = rand;
    end
end
