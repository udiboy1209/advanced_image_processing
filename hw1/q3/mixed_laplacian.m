X = -0.4:0.001:0.4;

L1 = zeros(size(X));
L2 = zeros(size(X));

pi1 = 0.4;
pi2 = 0.6;
s1 = 0.01;
s2 = 0.05;

L1 = pi1/2/s1*exp(-abs(X)/s1);
L2 = pi2/2/s2*exp(-abs(X)/s2);

% for i = 1:size(X,2)
%     x = X(i);
%     
%     L1(i) = pi1/2/s1*exp(-abs(x)/s1);
%     L2(i) = pi2/2/s2*exp(-abs(x)/s2);
% end

plot(X,[L1;L2;L1+L2]);