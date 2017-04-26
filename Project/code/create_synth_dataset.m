function [synth_img] = create_synth_dataset()
    m = 480;
    n = 720;
    synth_img = zeros(m,n,3);

    patch_size = 120;
    r_patch = zeros(patch_size,patch_size,3);
    r_patch(:,:,1) = ones(patch_size,patch_size);

    g_patch = zeros(patch_size,patch_size,3);
    g_patch(:,:,2) = ones(patch_size,patch_size);

    b_patch = zeros(patch_size,patch_size,3);
    b_patch(:,:,3) = ones(patch_size,patch_size);

    row = 1;
    col = 1;
    color_array = [115,82,68; 194, 150, 130; 98, 122, 157; 
                    87, 108, 67; 133, 128, 177; 103, 189, 170;
                    214, 126, 44; 80, 91, 166; 193, 90, 99;
                    94, 60, 108; 157, 188, 64; 224, 163, 46;
                    56, 61, 150; 70, 148, 73; 175, 54, 60;
                    231, 199, 31; 187, 86, 149; 8, 133, 161;
                    243, 243, 244; 200, 200, 200; 160, 160, 160;
                    122, 122, 121; 85, 85, 85; 52, 52, 52];

    k = 0;
    flag = 0;
    for row = 1:patch_size:m
        for col = 1:patch_size:n
            k = k +1;

            synth_img(row:row+patch_size-1,col:col+patch_size-1,:) = color_array(k,1)*r_patch +...
                            color_array(k,2)*g_patch + color_array(k,3) * b_patch;
            if (k==24)
                flag = 1;
                break;
            end
        end
        if (flag == 1)
            break;
        end
    end

%     figure; imshow(uint8(synth_img));

end