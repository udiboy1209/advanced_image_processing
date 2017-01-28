dt = 10^-3;
b = 1;
t = dt:dt:b; % 0 -> sqrt(b)

dI = 10^-3;

Ivals = 0:dI:1;
PI = zeros(size(Ivals));

for i = 1:size(Ivals,2)
    I = Ivals(i);
    val = sum(exp(bsxfun(@rdivide,-I^2,(2*t)))./sqrt(t) * dt);
    PI(i) = val/sqrt(2*pi)/(b);
end

PI = [fliplr(PI) PI(2:end)];
Ivals = [-fliplr(Ivals) Ivals(2:end)];
plot(Ivals,PI)
    