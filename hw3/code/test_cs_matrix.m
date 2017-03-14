function [] = test_cs_matrix(psi, examples)
% Q2 testing designed CS matrix
addpath 'ompbox10'

[phi_o,phi_d,normE] = design_cs_matrix(psi);

figure, plot(normE), title('|E| plot');

plot_off_diagonal(phi_o,psi);
plot_off_diagonal(phi_d,psi);

D_o = normc(phi_o*psi);
D_d = normc(phi_d*psi);
G_o = D_o'*D_o;
G_d = D_d'*D_d;

num_ex = size(examples, 2);

relError = zeros(num_ex,1);

for i = 1:num_ex
    xi = examples(:,i);
    
    y_o = phi_o*xi;
    y_d = phi_d*xi;
    
    theta_o = omp2(D_o, y_o, G_o, 1, 'gammamode','full');
    theta_d = omp2(D_d, y_d, G_d, 1, 'gammamode','full');
    
    x_o = psi*theta_o;
    x_d = psi*theta_d;
    
    err_o = norm(x_o - xi,1);
    err_d = norm(x_d - xi,1);
    
    relErr(i) = err_o/err_d;
end

fprintf('Avg relative error: %f',mean(relError));
rmpath 'ompbox10'
end