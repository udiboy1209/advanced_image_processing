function [theta,st,ti_out] = omp_implement(A,Eu,epsilon)
    % Vectorizes in column vector
    y = Eu(:);
    r = y;
    
    Ti = [];
    [M,N] = size(A);
    
    theta = zeros(N,1);
    
    % calculate norm2 of columns of A for normalisation
    normcolA = zeros(1,N);
    for j = 1:N
        normcolA(1,j) = norm(A(:,j),2);
    end 
    
    while(norm(r) > epsilon)
        
        % Normalised correlation of each col of A with r
        rAnorm = abs((r'*A) ./ normcolA);
        [~, j] = max(rAnorm);
        
        % add index to list
        Ti = [Ti j];
        
        At = A(:,Ti);
        s = (At' * At) \ At' * y;
        
        % new residue
        r = y - At*s;
    end
    
    ti_out = Ti;
    st = s;
    theta(ti_out) = st;
end
