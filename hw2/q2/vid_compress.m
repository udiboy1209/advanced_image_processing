function [all_frames] = vid_compress()
    [Eu, Ct_mat, T] = compute_coded_snapshot_with_noise();
    [H,W] = size(Eu);
    
    psi = kron(dctmtx(8),dctmtx(8));
    all_frames = zeros(H,W,T);
    num_added = zeros(H,W);
    for row = 1:H-7
        tic;
        for col = 1:W-7
            patch = Eu(row:row+7,col:col+7);
            ct_patch = Ct_mat(row:row+7,col:col+7,1:T);

            ct_patch_vec = reshape(ct_patch,[8*8,1,T]);
            phi_t = zeros(8*8,8*8*T);
            for i = 1:T
                ct_vec = ct_patch_vec(:,:,i);
                ct_vec = ct_vec(:);
                phi_t(:, (i-1)*64 + 1 : i*64) = diag(ct_vec) * psi;
            end
            [theta_out] = omp_implement2(patch,phi_t);
            
            for i = 1:T
                theta_out_frame_i = theta_out((i-1) * 64+ 1: i*64);
%                 new_theta_frame_i = reshape(theta_out_frame_i,[8,8]);
                frame_i = psi * theta_out_frame_i;
                all_frames(row:row+7,col:col+7,i) = all_frames(row:row+7,col:col+7,i) + reshape(frame_i,[8,8]);
            end
            
            num_added(row:row+7, col:col+7) = num_added(row:row+7, col:col+7) + 1;
            
        end
        toc;
        fprintf('Row %d done',row);
    end
    
    for i=1:T
        all_frames(:,:,i) = all_frames(:,:,i)./num_added;
        figure; imshow(all_frames(:,:,i),[]);
    end
    
end
