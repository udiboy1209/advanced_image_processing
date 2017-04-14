classdef RU_mat_t
    %RU_MAT_T Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        M, N, angles, num_angles
    end
    
    methods
        function o = RU_mat_t(M,N,angles)
            o.M = M;
            o.N = N;
            o.angles = angles;
            o.num_angles = length(angles);
        end
        function m = mtimes(RU,m2)
            % Assuming m1 is RU object and m2 is the image matrix
            [a,~] = size(m2);
            tom = reshape(m2,a/RU.num_angles,RU.num_angles);
            idct = iradon(tom,RU.angles,'linear','Ram-Lak',1,RU.M);
            m = dct2(idct);
            m = reshape(m, RU.M*RU.N, 1);
        end
    end
    
end

