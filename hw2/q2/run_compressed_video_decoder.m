[Eu,Ct_mat,T] = compute_coded_snapshot_with_noise();
figure;imshow(Eu,[]);
[H,W] = size(Eu);

Psi = kron(dctmtx(8),dctmtx(8));
out_vid = zeros(H,W,T);
num_added = zeros(H,W);

for i = 1:H-7
    tic;
    for j = 1:W-7
        A = zeros(64,64*T);
        patch = Eu(i:i+7,j:j+7);
        for t = 1:T
            Ct_patch = Ct_mat(i:i+7,j:j+7,t);
            phi_t_patch = diag(Ct_patch(:));
            A(:,(t-1)*64+1:t*64) = phi_t_patch*Psi;
        end
%         A_unit_norm = normc(A);

%         [st,ti_out] = omp_implement(patch,A_unit_norm);
        [decoded_patch] = omp_implement2(patch,A);
%         decoded_patch = zeros(64*T,1);
%         Indices of st and ti should match because
%         A_ti * st = y
%         decoded_patch(ti_out) = st;
        
        for t = 1:T
           decoded_frame = reshape(Psi*decoded_patch((t-1)*64+1:t*64),8,8);
           out_vid(i:i+7,j:j+7,t) = out_vid(i:i+7,j:j+7,t) + decoded_frame;
        end
        num_added(i:i+7,j:j+7) = num_added(i:i+7,j:j+7) + 1;
    end
    fprintf('Row %d done\n', i);
    toc;
end

for t = 1:T
    out_vid(:,:,t) = out_vid(:,:,t)./num_added;
    figure, imshow(out_vid(:,:,t),[]);
end
