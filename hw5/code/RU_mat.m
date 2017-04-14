classdef RU_mat
    %RU_MAT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        M, N, angles, num_angles
    end
    
    methods
        function o = RU_mat(M,N,angles)
            o.M = M;
            o.N = N;
            o.angles = angles;
            o.num_angles = length(angles);
        end
        function m = mtimes(RU,m2)
            % Assuming m1 is RU object and m2 is the image matrix
            dct_img = reshape(m2,RU.M,RU.N);
            im = idct2(dct_img);
            tom = radon(im,RU.angles);
            tom_len = size(tom,1);
            m = reshape(tom, tom_len*RU.num_angles, 1);
        end
    end
    
end

