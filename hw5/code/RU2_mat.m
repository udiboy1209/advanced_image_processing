classdef RU2_mat
    %RU_MAT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        M, N, angles1, angles2, num_angles
    end
    
    methods
        function o = RU2_mat(M,N,angles1,angles2)
            o.M = M;
            o.N = N;
            o.angles1 = angles1;
            o.angles2 = angles2;
            o.num_angles = length(angles1);
        end
        function m = mtimes(RU,m2)
            beta1 = m2(1:RU.M*RU.N);
            d_beta = m2(RU.M*RU.N+1:end);
            
            dct_1 = reshape(beta1,RU.M,RU.N);
            dct_d = reshape(d_beta,RU.M,RU.N);
            im_1 = idct2(dct_1);
            im_2 = idct2(dct_d + dct_1);
            
            tom_1 = radon(im_1,RU.angles1);
            tom_2 = radon(im_2,RU.angles2);
            
            tom_len = size(tom_1,1);
            m_1 = reshape(tom_1, tom_len*RU.num_angles, 1);
            m_2 = reshape(tom_2, tom_len*RU.num_angles, 1);
            
            m = [m_1; m_2];
        end
    end
    
end

