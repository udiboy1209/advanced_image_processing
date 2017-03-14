function [] = test_cs_matrix(psi, examples)
% Q2 testing designed CS matrix

[phi_o,phi_d, normE] = design_cs_matrix(psi);

figure, plot(normE);

plot_off_diagonal(phi_o,psi);
plot_off_diagonal(phi_d,psi);

num_ex = size(examples, 2);

for i = 1:num_ex
    xi = examples(:,i);
    
    y_o = phi_o*xi;
    y_d = phi_d*xi;
    
    [theta_o,st_o,ti_out_o] = omp_implement(phi_o*psi, y_o, 1);
    [theta_d,st_d,ti_out_d] = omp_implement(phi_d*psi, y_d, 2);
    
    x_o = psi*theta_o;
    x_d = psi*theta_d;
    
    err_o = norm(x_o - xi,1);
    err_d = norm(x_d - xi,1);
end

end