U = kron(dctmtx(32)',dctmtx(32)')';
RU = zeros(49*15,1024);

for m = 1:1024
   um = U(:,m);
   um = reshape(um,32,32);
   R = radon(um, 0:12:168);
   RU(:,m) = reshape(R,49*15,1);
end

RU = normc(RU);
coh = zeros(1024*1023/2,1);
k = 1;

for i = 1:1024
    for j = i+1:1024
        coh(k) = abs(RU(:,i)'*RU(:,j));
        k = k + 1;
    end
end

mu = max(coh);
histogram(coh);
