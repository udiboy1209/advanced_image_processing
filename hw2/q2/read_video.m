function [frames_out,H,W,T] = read_video()
    addpath ./MMread;
    T = 3;
    [vid,~] = mmread('../cars.avi',1:T);
    frames = vid.frames;
    
    [H,~,~] = size(frames(1).cdata);
    
    frames_out = zeros(120,240,T);
    
    for i=1:T
        frames_out(:,:,i) = rgb2gray(frames(i).cdata(H-119:H,1:240,:));
    end
    H = 120;
    W = 240;
    rmpath ./MMread;
end
