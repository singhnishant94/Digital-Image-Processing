%% MyMainScript

tic;
%% Your code here
img = imread('../data/baboonColor.png');
figure, imshow(mat2gray(img)), colorbar, title('original image');
gf = fspecial('gaussian', [5 5], 1.0);
smoothed = imfilter(img, gf);
smoothed = imresize(smoothed, 0.5);
figure, imshow(smoothed), colorbar, title('smoothed image');
output = myMeanShiftSegmentation(smoothed, 32, 16, 20, 50);
figure, imshow(mat2gray(output)), colorbar, title('final output');
%% parameters
%{
patch size = 50
Gaussian kernel bandwidth for the spatial feature: 32 
Gaussian kernel bandwidth for the intensity feature: 16
Iterations: 20
%}

toc;
