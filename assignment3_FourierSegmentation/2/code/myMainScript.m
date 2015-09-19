%% MyMainScript

tic;
%% Your code here
imgStruct = load('../data/boat.mat');
img = imgStruct.imageOrig;
img = mat2gray(img);
figure, imshow(img), title('original');

%first parameter(sigma of gaussian blur) = 0.5
gblur = fspecial('gaussian', [3 3], 0.5);
img = imfilter(img, gblur);

%params k = 0.1, sigma for gaussian weight = 1.0
[Ix, Iy, eigIm1, eigIm2, Corner] = myHarrisCornerDetector(img, 1.0, 0.1);
%{
figure, imshow(Ix, [0 1]), colorbar, title('Derivative in x-direction'), truesize;
figure, imshow(Ix, [0 1]), colorbar, title('Derivative in x-direction'), truesize;
%}
figure, imshow(Ix, [min(Ix(:)) max(Ix(:))]), colorbar, title('Derivative in x-direction'), truesize;
figure, imshow(Iy, [min(Iy(:)) max(Iy(:))]), colorbar, title('Derivative in y-direction'), truesize;

figure, imshow(eigIm1, [min(eigIm1(:)) max(eigIm1(:))]), colorbar, title('Image for eigen value 1'), truesize;
figure, imshow(eigIm2, [min(eigIm2(:)) max(eigIm2(:))]), colorbar, title('Image for eigen value 2'), truesize;
figure, imshow(Corner, [min(Corner(:)) max(Corner(:))]), colorbar, title('Cornerness measure'), truesize;

%figure, imshow(img);
toc;
