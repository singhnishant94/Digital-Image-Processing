function output = myUnsharpMasking( img, sigma, s )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
h = fspecial('gaussian', 5, sigma);
blurred = imfilter(img, h);
mask = img - blurred;
output = img + s*mask;
%{
disp(h);
delta_row = floor(5/2);
delta_col = floor(5/2);
img = padarray(img, [delta_row delta_col], 'replicate','post');
%hh = fspecial('motion', 50, 45);
%disp(hh);

mask = img - blurred;
output = img + s*mask;
%mask = img - imfilter(img, h);
%output = img - s*(mask);
%}
%{
filtered = imfilter(img, h);

mask = s*filtered;
%disp(mask);
%figure, imshow(mask);

output = img - mask;
%}


end

