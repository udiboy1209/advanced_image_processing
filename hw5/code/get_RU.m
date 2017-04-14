function [RU] = get_RU(U,sz_ru,angles)
%     U = kron(dctmtx(32)',dctmtx(32)')';
    [a,b] = size(U);
    len_angles = length(angles);
    RU = zeros(sz_ru*len_angles,a);

    for m = 1:a
       um = U(:,m);
       um = reshape(um,sqrt(a),sqrt(a));
       R = radon(um, angles);
       RU(:,m) = reshape(R,sz_ru*len_angles,1);
    end
end