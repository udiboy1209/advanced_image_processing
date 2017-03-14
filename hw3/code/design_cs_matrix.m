function [phi_o, phi_d, normE] = design_cs_matrix(psi)
    %psi = randn(64,128);
%     psi = normc(psi);
    n = size(psi,1);
    
    m = 40;
    phi_o = randn(m,n);
%     phi_o = normc(phi_o);
    
    phi_cap = phi_o;
    
    [V,lambda] = eig(psi * psi');
    lambda_vec = diag(lambda);
    ind = find(lambda_vec ~= 0);
    r = sum(lambda_vec ~= 0);
    
    tau_cap = phi_cap * V;
    normE = zeros(m,1);
%     norm_initial = zeros(m,1);
    %tau_res = zeros(size(tau_cap));
    E = lambda - lambda * (tau_cap' * tau_cap) * lambda;
    
    for j = 1:m
%         E = lambda - lambda * (tau_cap' * tau_cap) * lambda;
        tau_j = tau_cap(j,:);
        vj = (tau_j').*lambda_vec;
        Ej = E + vj * vj';
%         [u1,e1] = eigs(Ej,1);
        [u,s,v] = svd(Ej);
%         vj_new = sqrt(e1)*u1;
        vj_new = sqrt(s(1,1))*u(:,1);
        E = Ej - s(1,1)*u(:,1)*v(:,1)';
%         E_new = Ej + vj_new*vj_new';
        normE(j) = norm(E(:), 'fro');
        tau_cap(j,1:r) = vj_new(1:r)./lambda_vec(1:r);
    end

%     tau_cap = diag(lambda_vec.^(-1/2));
%     tau_cap = tau_cap(1:40,:);
%     phi_init = phi_o;
%     for i = 1:40
%         [u, s, v] = svd(phi_init*psi);
%         snew = [eye(40);zeros(88,40)];
%         phi_init = (inv(psi*psi')*psi*v*snew*u')';
%     end
% 
%     phi_d = phi_init;

    phi_d = tau_cap * V';
%     phi_d = normc(phi_d);
end
