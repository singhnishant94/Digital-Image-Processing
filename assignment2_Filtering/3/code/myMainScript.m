%% MyMainScript

tic;
%% Your code here

imgstruct3 = load('../data/barbara.mat');
img3 = imgstruct3.imageOrig;
filt = fspecial('gaussian', [5 5], 0.66);
noisy = imfilter(img3, filt, 'same');




%img3 = img3/(max(max(img3)) - min(min(img3)));

newimg = double(zeros(size(img3)/2));
for i=1:size(img3,1)
    for j=1:size(img3,2)
        if rem(i,2) == 0
            if rem(j,2) == 0
                newimg(i/2, j/2) = noisy(i,j);
            end;
        end;
    end;
end;


%figure, imshow(uint8(img3)), title('original');
figure, imshow(uint8(newimg)), title('noisy');
%}

img = imread('../data/barbaraSmall.png');
img = double(img);
img = img./255;

sigma_opt = 1.0;
output = myPatchBasedFiltering(newimg, sigma_opt);
rmsd = sum(sum((newimg - output).^2));
rmsd = rmsd/(size(newimg,1)*size(newimg,2));
rmsd = sqrt(rmsd);
disp('optimal rmsd for sigma = 1.0');
disp(rmsd);

output = myPatchBasedFiltering(newimg, 0.9*sigma_opt);
rmsd = sum(sum((newimg - output).^2));
rmsd = rmsd/(size(newimg,1)*size(newimg,2));
rmsd = sqrt(rmsd);
disp('optimal rmsd for sigma = 0.9*sigma_opt');
disp(rmsd);

output = myPatchBasedFiltering(newimg, 1.1*sigma_opt);
rmsd = sum(sum((newimg - output).^2));
rmsd = rmsd/(size(newimg,1)*size(newimg,2));
rmsd = sqrt(rmsd);
disp('optimal rmsd for sigma = 1.1*sigma_opt');
disp(rmsd);



figure, imshow(uint8(img3)), title('original');
figure, imshow(uint8(output)), title('patchfiltered');


toc;
