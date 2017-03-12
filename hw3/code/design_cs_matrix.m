function [psi,phi_o, phi_d] = design_cs_matrix()
    psi = randn(64,128);
    m = 40;
    phi_o = randn(m,64);
    
    phi_cap = phi_o;
    
    [V,lambda] = eig(psi * psi');
    lambda_vec = diag(lambda);
    ind = find(lambda_vec ~= 0);
    r = sum(lambda_vec ~= 0);
    
    tau_cap = phi_cap * V;
    
    
    for j = 1:m
        E = lambda - lambda * (tau_cap' * tau_cap) * lambda;
        tau_j = tau_cap(j,:);
        tau_j = tau_j';
        vj = tau_j.*lambda_vec;
        Ej = E + vj * vj';
        [u1,e1] = eigs(Ej,1);
        %No idea why e1 is becoming negative???
        vj_new = sqrt(e1)*u1;
        tau_cap(j,ind) = vj_new(ind)./lambda_vec(ind);
    end
    phi_d = tau_cap * V';   
end
