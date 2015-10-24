function result = myPCAdenoising2( img, sigma )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
sz = size(img);
N = (sz(1)-6)*(sz(2)-6);

MM = 7;
indices = reshape(1:sz(1)*sz(2), [sz(1), sz(2)]);

K = 200;
k = 200;

l = 0; u = 0; d = 0; r = 0;
c = 0;
h = waitbar(0, 'processing image');
final = [];

result = double(zeros(size(img)));
mask = double(zeros(size(img)));
for i=1:sz(1)-6
    for j=1:sz(2)-6
        waitbar(c/N);
        l = max(1, j-15);
        r = min(sz(2), j+15);
        u = max(1, i-15);
        d = min(sz(1), i+15);
        subp = img(u:d, l:r);
        subimg = img(i:i+6, j:j+6);
        vec = reshape(subimg, 49, 1);
        nbrs = im2col(subp, [MM MM], 'sliding');
        k = min(200, (r-l-5)*(d-u-5));
        
        inds = knnsearch(nbrs', vec', 'K', k);
        q = nbrs(:, inds);
        
        [V D] = eig(q*q');
        ecoff = V'*q;
        veccoff = V'*vec;
        sq = ecoff.*ecoff;
        sums = sum(sq, 2)/k - sigma^2;
        maxalpha = max(sums, 0);
        denoised = double(zeros(size(vec)));
        
        
        for it=1:size(maxalpha,1)
            denoised(it, :) = veccoff(it,:)/(1+(sigma^2)/maxalpha(it,1));
        end;
        reconstr = V*denoised;
        result(i:i+6, j:j+6) = result(i:i+6, j:j+6) + reshape(reconstr, 7, 7);
        mask(i:i+6, j:j+6) = mask(i:i+6, j:j+6) + 1;
        c = c+1;
    end;
end;
delete(h);
result = result./mask;

end

