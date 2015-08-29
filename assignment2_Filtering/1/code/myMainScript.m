%% MyMainScript

tic;
%% For lion image

imgstruct1 = load('../data/lionCrop.mat');
img1 = imgstruct1.imageOrig;
output = myUnsharpMasking(img1, 1.2, 2.0);

% Linear contrast stretching
img1 = imadjust(img1,stretchlim(img1),[]);
output = imadjust(output,stretchlim(output),[]);

% optimal parameters: 1.2, 2.0

figure, imshow(img1), title('original');
figure, imshow(output), title('sharpened');

%% For moon image
imgstruct2 = load('../data/superMoonCrop.mat');
img2 = imgstruct2.imageOrig;
output = myUnsharpMasking(img2, 1.2, 5.0);

% Linear contrast stretching
img1 = imadjust(img1,stretchlim(img1),[]);
output = imadjust(output,stretchlim(output),[]);

%optimal parameters: 1.2, 4.0

figure, imshow(img2), title('original');
figure, imshow(output), title('sharpened');


toc;
