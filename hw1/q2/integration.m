dt = 10^-4;
b = 0.14;
t = dt:dt:b; % 0 -> sqrt(b)

dI = 10^-3;

Ivals = 0:dI:1;
PI = zeros(size(Ivals));

for i = 1:size(Ivals,2)
    I = Ivals(i);
    val = sum(exp(bsxfun(@rdivide,-I^2,(2*t)))./sqrt(t) * dt);
    PI(i) = val/sqrt(2*pi)/b;
end

%intg = arrayfun(@(I) dct_distribution_uniform_var(0,sqrt(1000),10000,I), Ivals);

%figure;
%plot(Ivals,[intg]);

PI = [fliplr(PI) PI(2:end)];
% PI = PI/sum(PI);
Ivals = [-fliplr(Ivals) Ivals(2:end)];

%lnpi = log(PI);
%coeffs = polyfit(Ivals, lnpi, 2)

g = fit(Ivals.', PI.','gauss1');
% Gvals = exp(coeffs(1)*Ivals.^2 + coeffs(3));
% Gvals = 1/(sqrt(2*pi)*1.05)*exp(-Ivals.^2/(2*(1.05)^2));
Gvals = g(Ivals);
figure;
plot(Ivals,[PI;Gvals']);
    