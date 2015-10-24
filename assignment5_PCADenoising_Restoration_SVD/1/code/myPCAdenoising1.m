function result = myPCAdenoising1( img, sigma )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

sz = size(img);
N = (sz(1)-6)*(sz(2)-6);

MM = 7;
P = im2col(img, [MM MM], 'sliding');
indices = reshape(1:sz(1)*sz(2), [sz(1), sz(2)]);

[V D] = eig(P*P');
ecoff = V'*P;

maxalpha = double(zeros(49,1));
sums = double(zeros(49,1));
sq = ecoff.*ecoff;
sums = sum(sq, 2)/N - sigma^2;
maxalpha = max(sums, 0);

denoised = double(zeros(size(P)));
for i=1:size(maxalpha,1)
    denoised(i, :) = ecoff(i,:)/(1+(sigma^2)/maxalpha(i,1));
end;

reconstr = V*denoised;

subs = im2col(indices, [MM, MM], 'sliding');
result=accumarray(subs(:),reconstr(:))./accumarray(subs(:),1);
result=reshape(result,sz(1),sz(2));


end

