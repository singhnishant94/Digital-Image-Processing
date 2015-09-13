function output = myButterworthFiltering( img, d0, n )
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
lp_filter = zeros(size(img));
r = size(img,1);
c = size(img,2);
for i = 1:r
    for j = 1:c
        if(sqrt(((i-r/2)^2 + (j-c/2)^2)) < 50)
            lp_filter(i,j) = 1;
        end;
    end;
end;


bw_filter = zeros(size(img));
for i = 1:r
    for j = 1:c
        bw_filter(i,j) = 1/(1+(sqrt((i-r/2)^2+(j-c/2)^2)/d0)^(2*n));
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
%}
end

