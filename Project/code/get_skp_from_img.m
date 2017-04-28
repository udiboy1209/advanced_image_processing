function [u1, u2, Is] = get_skp_from_img(img)

% img = double(imread('../datasets/dataset_cannon/synth_bg_sub/img1.png'));

[M,N,C] = size(img);

mu_s = [];
var_s = [];
Is = [];

figure, imshow(uint8(img));
hold on;

y = 1;
while y < M
    x = 1;
    if y + 9 > M
       break;
   end
    
    while x < N
       patchsize = 9;
       flag = 0;
       while 1
           if x + patchsize > N || y + patchsize > M
               patchsize = patchsize - 1;
               if flag == 1
                  [mu,var,I] = get_mu_s(img(y:y+patchsize,x:x+patchsize,:));
           
                   mu_s = [mu_s; mu];
                   var_s = [var_s; var];
                   Is = [Is; I];
                   
                   rectangle('Position',[x y patchsize patchsize]);  
               end
               break;
           end
           
           [mu,var,I] = get_mu_s(img(y:y+patchsize,x:x+patchsize,:));
           if sum(abs(mu) > 0.1) == 3
               patchsize = patchsize - 1;
               
               if patchsize >= 9
                   [mu,var,I] = get_mu_s(img(y:y+patchsize,x:x+patchsize,:));
           
                   mu_s = [mu_s; mu];
                   var_s = [var_s; var];
                   Is = [Is; I];
                   
                   rectangle('Position',[x y patchsize patchsize]); 
               end
               break
           else
               patchsize = patchsize + 1;
               flag = 1;
           end
       end
       x = x + patchsize + 1;
    end
    y = y + patchsize + 1;
end
hold off;
title('Homogenous Patches');

u1 = (mu_s+var_s)/2;
u2 = (-mu_s+var_s)/2;

% for c = 1:C
%     figure, scatter(Is(:,c),u1(:,c),'.');
% end

end
        