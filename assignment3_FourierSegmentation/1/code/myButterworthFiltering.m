function [bw_filter, output] = myButterworthFiltering( img, d0, n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ft = fft2(img);
%{
figure, imshow(ft), title('uncentered');
ft = fftshift(ft);
figure, imshow(ft), title('centered');

output = ifft2(ft);
%}
ft = fftshift(ft);

r = size(img,1);
c = size(img,2);


bw_filter = zeros(size(img));
for i = 1:r
    for j = 1:c
        bw_filter(i,j) = 1/(1+(sqrt((i-floor(r/2)+1)^2+(j-floor(c/2)+1)^2)/d0)^(2*n));
    end;
end;

out = ft.*bw_filter;
%disp(out);
%{
disp(filtered_ft);
output = filtered_ft;
%}
out = ifftshift(out);
output = ifft2(out);
output = abs(output);
%}
end

