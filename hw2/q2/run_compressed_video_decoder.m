[Eu,Ct_mat,T] = compute_coded_snapshot_with_noise();

[H,W] = size(Eu);

Psi = kron(dctmtx(8),dctmtx(8));

for i = 1:H-7
    for j = 1:W-7
        A = zeros(64,64*T);
        patch = Eu(i:i+7,j:j+7);
        for t = 1:T
            Ct_patch = Ct_mat(i:i+7,j:j+7,t);
            A(:,t:T:64*T) = diag(Ct_patch(:));
        end

        [st,ti_out] = omp_implement(patch,A);
    end
end
