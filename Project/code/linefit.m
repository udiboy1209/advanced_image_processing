function [m1,c1,m2,c2] = linefit(u1,u2,I)

addpath ./Robust
colors = size(u1,2);

m1 = zeros(1,colors);
c1 = zeros(1,colors);
m2 = zeros(1,colors);
c2 = zeros(1,colors);

for c= 1:colors
    Ic = I(:,c);
    u1c = u1(:,c);
    u2c = u2(:,c);
    
    pts = [Ic';u1c';zeros(size(u1c'))];

    [V_u1,~,~] = ransacfitline(pts,5,1);

    m1(c) = (V_u1(2,2)-V_u1(2,1))/(V_u1(1,2)-V_u1(1,1));
    c1(c) = V_u1(2,2)-m1(c)*V_u1(1,2);

    pts(2,:) = u2c';

    [V_u2,~,~] = ransacfitline(pts,5,1);

    m2(c) = (V_u2(2,2)-V_u2(2,1))/(V_u2(1,2)-V_u2(1,1));
    c2(c) = V_u2(2,2)-m2(c)*V_u2(1,2);
end

figure,
for c = 1:colors
    if c == 1
        col = '.r';
        lcol = '--m';
    elseif c == 2
        col = '.g';
        lcol = '--y';
    else
        col = '.b';
        lcol = '--c';
    end
    
    scatter(I(:,c),u1(:,c),col); hold on;
    plot([0 255],[c1(c) 255*m1(c)+c1(c)],lcol); 
end
hold off;
title('\mu^{(1)} vs. Intensity');
legend('R channel data', 'R channel fit', 'G channel data', 'G channel fit', 'B channel data', 'B channel fit');

figure,
for c = 1:colors
    if c == 1
        col = '.r';
        lcol = '--m';
    elseif c == 2
        col = '.g';
        lcol = '--y';
    else
        col = '.b';
        lcol = '--c';
    end
    
    scatter(I(:,c),u2(:,c),col); hold on;
    plot([0 255],[c2(c) 255*m2(c)+c2(c)],lcol);   
end
hold off;
title('\mu^{(2)} vs. Intensity');
legend('R channel data', 'R channel fit', 'G channel data', 'G channel fit', 'B channel data', 'B channel fit');


rmpath ./Robust

end