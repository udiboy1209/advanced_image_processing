function [all_frames] = vid_compress()
    [Eu, Ct_mat, T,sigma, original_frames] = compute_coded_snapshot_with_noise();
    [H,W] = size(Eu);
    
    psi = kron(dctmtx(8)',dctmtx(8)');
    all_frames = zeros(H,W,T);
    num_added = zeros(H,W);
    
    % epsilon = sqrt(patch_size*patch_size*sigma^2) = 8 sigma
    eps =  8*sigma;
    for row = 1:H-7
        tic;
        for col = 1:W-7
            
            % Take patch of coded snapshot image and corresponding code
            patch = Eu(row:row+7,col:col+7);
            ct_patch = Ct_mat(row:row+7,col:col+7,1:T);

            % Calculate A matrix from the patch of code matrix
            ct_patch_vec = reshape(ct_patch,[8*8,1,T]);
            phi_t = zeros(8*8,8*8*T);
            for i = 1:T
                ct_vec = ct_patch_vec(:,:,i);
                phi_t(:, (i-1)*64 + 1 : i*64) = diag(ct_vec) * psi;
            end
            
            patch_vec = patch(:);
            [theta_out] = omp_implement(phi_t,patch_vec,eps);
            for i = 1:T
                theta_out_frame_i = theta_out((i-1) * 64+ 1: i*64);

                % Inverse DCT
                frame_i = psi * theta_out_frame_i;
                all_frames(row:row+7,col:col+7,i) = all_frames(row:row+7,col:col+7,i) + reshape(frame_i,[8,8]);
            end
            
            num_added(row:row+7, col:col+7) = num_added(row:row+7, col:col+7) + 1;
        end
        toc;
        fprintf('Row %d done\n',row);
    end
    
    % Place original and decoded side by side
    save_img = zeros(H,W*2);
    
    figure; title('Decoded frames vs. Original frames');
    for i=1:T
        all_frames(:,:,i) = all_frames(:,:,i)./num_added;
        save_img(:,1:W) = all_frames(:,:,i);
        save_img(:,W+1:end) = original_frames(:,:,i);
        
        fname = sprintf('output/frame_%d.png',i);
        imwrite(uint8(save_img),fname,'PNG');
        
        subplot(T,1,i);
        imshow(save_img,[]);
    end
    
end
