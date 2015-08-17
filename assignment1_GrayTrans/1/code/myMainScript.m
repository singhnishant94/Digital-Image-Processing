
myNumOfColors= 256;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
displayGrayScale = @(image, title) dispimage(image, title, myColorScale, gray);

%% Defining and Reading test input files

barbara_f = '../data/barbaraSmall.png';
circles_f = '../data/circles_concentric.png';

barbara = imread(barbara_f);
circles = imread(circles_f);
%% Image shrinking

%%
% *Original Image*
displayGrayScale(circles, 'original circles');

%%
% *Shrinked by factor of 2*
output = myShrinkImageByFactorD(circles, 2);
displayGrayScale(output, 'd=2');

%%
% *Shrinked by factor of 3*
output = myShrinkImageByFactorD(circles, 3);
displayGrayScale(output, 'd=3');

%% Image Enlargement
% *Original Image*
displayGrayScale(barbara, 'Original Barbara');

%%
% *Bilinear Interpolaion*
output = myBilinearInterpolation(barbara);
displayGrayScale(output, 'barbara BI');

%%
% *Nearest Neighbour Interpolation*
output = myNearestNeighborInterpolation(barbara);
displayGrayScale(output, 'barbara NNI');

toc;