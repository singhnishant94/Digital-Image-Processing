%% MyMainScript

tic;
%% Bilateral filtering
imgstruct3 = load('../data/barbara.mat');
img3 = imgstruct3.imageOrig;


%img3 = (img3-min(min(img3)))/(max(max(img3)) - min(min(img3)));


corrupted = double(zeros(size(img3)));
sd = 0.05*(max(max(img3)) - min(min(img3)));

for i=1:size(img3,1)
    for j=1:size(img3,2)
        corrupted(i,j) = img3(i,j) + normrnd(0, sd);
    end;
end;

figure, imshow(uint8(corrupted)), title('corrupted');
% optimal spatial sigma
sigma_d_opt = 1.45;

% optimal intensity sigma
sigma_r_opt = 10.0;
output = myBilateralFiltering(corrupted, sigma_d_opt, sigma_r_opt);
rmsd = sum(sum((img3 - output).^2));
rmsd = rmsd/(size(img3,1)*size(img3,2));
rmsd = sqrt(rmsd);
disp('rmsd for sigma_d* and sigma_r*'); 
disp(rmsd);

 
img3_show = uint8(img3);
output1 = uint8(output);
figure, imshow(img3_show), title('original');
figure, imshow(uint8(output1)), title('final');


output = myBilateralFiltering(corrupted, 0.9*sigma_d_opt, sigma_r_opt);
rmsd = sum(sum((img3 - output).^2));
rmsd = rmsd/(size(img3,1)*size(img3,2));
rmsd = sqrt(rmsd);
disp('rmsd for 0.9sigma_d* and sigma_r*'); 
disp(rmsd);

output = myBilateralFiltering(corrupted, 1.1*sigma_d_opt, sigma_r_opt);
rmsd = sum(sum((img3 - output).^2));
rmsd = rmsd/(size(img3,1)*size(img3,2));
rmsd = sqrt(rmsd);
disp('rmsd for 1.1sigma_d* and sigma_r*'); 
disp(rmsd);

output = myBilateralFiltering(corrupted, sigma_d_opt, 0.9*sigma_r_opt);
rmsd = sum(sum((img3 - output).^2));
rmsd = rmsd/(size(img3,1)*size(img3,2));
rmsd = sqrt(rmsd);
disp('rmsd for sigma_d* and 0.9sigma_r*'); 
disp(rmsd);

output = myBilateralFiltering(corrupted, sigma_d_opt, 1.1*sigma_r_opt);
rmsd = sum(sum((img3 - output).^2));
rmsd = rmsd/(size(img3,1)*size(img3,2));
rmsd = sqrt(rmsd);
disp('rmsd for sigma_d* and 1.1sigma_r*'); 
disp(rmsd);


%optimal sigma_d-8.0, sigma_r-8.0
%disp(output - img3);


toc;
