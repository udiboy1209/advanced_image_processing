function [m1,c1,m2,c2] = linefit(u1,u2,I)

addpath ./Robust

pts = [I';u1';zeros(size(u1'))];

[V_u1,~,~] = ransacfitline(pts,5,1);

m1 = (V_u1(2,2)-V_u1(2,1))/(V_u1(1,2)-V_u1(1,1));
c1 = V_u1(2,2)-m1*V_u1(1,2);

figure,
scatter(I,u1,'.'); hold on;
plot([0 255],[c1 255*m1+c1],'r'); legend('Data','RANSAC');
hold off; title('\mu^{(1)} vs. Intensity');

pts(2,:) = u2';

[V_u2,~,~] = ransacfitline(pts,5,1);

m2 = (V_u2(2,2)-V_u2(2,1))/(V_u2(1,2)-V_u2(1,1));
c2 = V_u2(2,2)-m1*V_u2(1,2);

figure,
scatter(I,u2,'.'); hold on;
plot([0 255],[c1 255*m2+c2],'r'); legend('Data','RANSAC');
hold off; title('\mu^{(2)} vs. Intensity');

rmpath ./Robust

end