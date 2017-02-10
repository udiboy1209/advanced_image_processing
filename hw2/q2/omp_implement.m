function [st,ti_out] = omp_implement(Eu,A)
    % [H,W] = size(Eu);
    %[Eu,Ct_vec] = compute_coded_snapshot_with_noise();
    pnorm_r = 0;
    epsilon = 10^-3;
    % Consider y = A(PSI)(THETA)
    s = 0;
    % Vectorizes in column vector
    y = Eu(:);
    r = y;
    
    Ti = [];
    
    % A = zeros(W*H,W*H*T);
    % for i = 1:T
    %    A((i-1)*W*H + 1:i*W*H,:) = diag(Ct_vec((i-1)*W*H + 1:i*W*H)); 
    % end
    
    while(abs(norm(r)-pnorm_r) > epsilon)
        pnorm_r = norm(r);
        [~,j] = choose_max_aj_similar(r,A);
        Ti = union(Ti,j);
        At = A(:,Ti);
        s = pinv(At) * y;
        
        r = y - At*s;
    end
    ti_out = Ti;
    st = s;
    
end
