function [rmse_vec] = find_rmse()
%     f1 = imread('../report/images/frame_4_t4.png');
%     [m,n] = size(f1);
%     rmse_vec(1) = rmse(f1(:,1:n/2),f1(:,n/2+1:end));
    rmse_vec = zeros(1,7);
    rmse_vec(1,1:3) = [9.1962, 9.0213, 9.2965];
    rmse_vec(1,4:7) = [11.1252, 10.5523, 10.5981, 10.8642];
end
