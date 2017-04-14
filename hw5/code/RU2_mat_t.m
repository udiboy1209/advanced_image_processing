classdef RU2_mat_t
    %RU_MAT_T Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        M, N, angles1, angles2, num_angles
    end
    
    methods
        function o = RU2_mat_t(M,N,angles1,angles2)
            o.M = M;
            o.N = N;
            o.angles1 = angles1;
            o.angles2 = angles2;
            o.num_angles = length(angles1);
        end
        function m = mtimes(RU,m2)
            % Assuming m1 is RU object and m2 is the image matrix
            [a,~] = size(m2);
            a = a/2;
            
            tom_1 = m2(1:a);
            tom_2 = m2(a+1:end);
            
            tom_1 = reshape(tom_1,a/RU.num_angles,RU.num_angles);
            tom_2 = reshape(tom_2,a/RU.num_angles,RU.num_angles);
            
            idct_1 = iradon(tom_1,RU.angles1,'linear','Ram-Lak',1,RU.M);
            idct_2 = iradon(tom_2,RU.angles2,'linear','Ram-Lak',1,RU.M);
            
            m_1 = dct2(idct_1);
            m_2 = dct2(idct_2);
            
            m_1 = reshape(m_1, RU.M*RU.N, 1);
            m_2 = reshape(m_2, RU.M*RU.N, 1);
            
            m = [m_1; m_2-m_1];
        end
    end
    
end

