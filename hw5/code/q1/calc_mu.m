U = kron(dctmtx(32)',dctmtx(32)');
RU = zeros(49*15,1024);

for m = 1:1024
   um = U(:,m);
   um = reshape(um,32,32);
   R = radon(um, 0:12:168);
   RU(:,m) = reshape(R,49*15,1);
end

RU = normc(RU);
C = abs(RU'*RU);
offdiag_idx = logical(1-eye(1024));

mu = max(max(C(offdiag_idx)))
histogram(C(offdiag_idx));
