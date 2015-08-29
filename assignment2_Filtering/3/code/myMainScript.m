%% MyMainScript

tic;
%% Your code here
%{
imgstruct3 = load('../data/barbara.mat');
img3 = imgstruct3.imageOrig;
img3 = img3/(max(max(img3)) - min(min(img3)));

newimg = double(zeros(size(img3)/2));
for i=1:size(img3,1)
    for j=1:size(img3,2)
        if rem(i,2) == 0
            if rem(j,2) == 0
                newimg(i/2, j/2) = img3(i,j);
            end;
        end;
    end;
end;
figure, imshow(img3);
figure, imshow(newimg);
%}
img = imread('../data/barbaraSmall.png');
img = double(img);
img = img./255;


output = myPatchBasedFiltering(img, 0.5, 0.5);
disp(output);

figure, imshow(img), title('original');
figure, imshow(output), title('patchfiltered');


toc;
