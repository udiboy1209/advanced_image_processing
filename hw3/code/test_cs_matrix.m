% Q2.A testing designed CS matrix

[psi,phi_o,phi_d, normE] = design_cs_matrix();

figure, plot(normE);

plot_off_diagonal(phi_o,psi);
plot_off_diagonal(phi_d,psi);

for i = 1:2000
    rand_col_ind = randi(64,5,1);
    rand_weight = rand(5,1);
    psi_rand_cols = psi(:,rand_col_ind);
    
    xi = psi_rand_cols * rand_weight;
    
    y_o = phi_o*xi;
    y_d = phi_d*xi;
    
    [theta_o,st_o,ti_out_o] = omp_implement(phi_o*psi, y_o, 1);
    [theta_d,st_d,ti_out_d] = omp_implement(phi_d*psi, y_d, 2);
    
    x_o = psi*theta_o;
    x_d = psi*theta_d;
    
    err_o = norm(x_o - xi,1);
    err_d = norm(x_d - xi,1);
end