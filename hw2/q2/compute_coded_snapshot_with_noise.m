function [Eu,Ct_mat,T,sigma, frames_out] = compute_coded_snapshot_with_noise()
    [frames_out,H,W,T] = read_video();
    Ct_vec = generate_random_code_pattern(H,W,T);
    Eu = zeros(H,W);
    Ct_mat = zeros(H,W,T);
    sigma = 2;
    for i=1:T
        ct = reshape(Ct_vec((i-1)*H*W+1:i*H*W),H,W);
        Ct_mat(:,:,i) = ct;
        Eu = Eu + ct.*frames_out(:,:,i);
    end
    
    Eu = Eu + randn(H,W)*sigma;
    figure;
    imshow(Eu,[]);
    title('Noisy coded image');

end
