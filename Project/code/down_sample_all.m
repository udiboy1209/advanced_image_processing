% top_dir = '/media/arktheshadow/Windows/dataset_cannon/100CANON';
% top_dir = '/media/arktheshadow/Windows/dataset_cannon/stable_img';
top_dir = '/media/arktheshadow/Windows/dataset_cannon/very_stable_img';

files = dir(top_dir);

for i = 3:length(files)
    in_file_name = fullfile(top_dir,files(i).name);
    img = imread(in_file_name);
    out_img = down_sample(img);
    str = sprintf('%d.png',i);
    file_name = fullfile('../data/canon_images_very_stable',str);
    imwrite(out_img,file_name);
    fprintf('Iter %d\n',i);
end