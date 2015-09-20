%% MyMainScript

tic;
%% Your code here
x = load('../data/boat.mat');

img = x.imageOrig;
n_img = img/255;
figure, imshow(n_img), title('original image');
noisy = imnoise(n_img, 'gaussian', 0, 0.01);
noisy = noisy*255;
figure, imshow(uint8(noisy)), title('noisy image');
minrmsd = 10000;
mind0 = 50;
%{
for i = 50:120
    [bw_filter, temp] = myButterworthFiltering(noisy, i, 2);
    rmsd = sum(sum((temp - img).^2));
    rmsd = rmsd/(size(img,1)*size(img,2));
    rmsd = sqrt(rmsd);
    if(rmsd < minrmsd) 
        minrmsd = rmsd;
        mind0 = i;
        output = temp;
    end;
end;
disp(['minimum d0 =' num2str(mind0)]);
disp(['minimum rmsd =' num2str(minrmsd)]);
%}


% optimal d0 = 100
[bw_filter, output] = myButterworthFiltering(noisy, 100, 2);

figure, imshow(imadjust(bw_filter)), title('butterworth filter');
%disp(rmsd);
figure, imshow(uint8(output)), title('filtered image');

rmsd = sum(sum((output - img).^2));
rmsd = rmsd/(size(img,1)*size(img,2));
rmsd = sqrt(rmsd);

%optimal rmsd
disp('optimal d0: 100');
disp(['optimal rmsd: ' num2str(rmsd)]);

[bw, out] = myButterworthFiltering(noisy, 95, 2);
rmsd = sum(sum((out - img).^2));
rmsd = rmsd/(size(img,1)*size(img,2));
rmsd = sqrt(rmsd);

%optimal rmsd

disp(['0.95*d0 rmsd: ' num2str(rmsd)]);

[bw, out] = myButterworthFiltering(noisy, 105, 2);
rmsd = sum(sum((out - img).^2));
rmsd = rmsd/(size(img,1)*size(img,2));
rmsd = sqrt(rmsd);

%optimal rmsd

disp(['1.05*d0 rmsd: ' num2str(rmsd)]);


ft = fft2(img);
ft = fftshift(ft);

r = size(ft, 1);
c = size(ft, 2);
%{
logft = log(ft);
figure, imshow(abs(logft), [min(min(abs(logft))) max(max(abs(logft)))]), title('fourier transform of the image');
%}
dc = ft(r/2, c/2);
disp(['dc offset: ' num2str(abs(dc))]);
energy = sum(sum(abs(ft).^2));
disp(['total energy of ft: ' num2str(energy)]);

%{
radius 1.4 - 90.5633 (88)
radius 2.2 - 90.6931 (91)
radius 2.3 - 92.6178 (92)
radius 4.4 - 93.9973 (94)
radius 14 - 96.9826 (97)
radius 59 - 99.0074 (99)
%}

radii = [1.4 2.2 2.3 4.4 14 59];
for i=1:6
    R = radii(i);
    filtered = zeros(size(ft));
    for a=1:r
        for b=1:c
            dist = sqrt((a-r/2)^2 + (b-c/2)^2);
            if(dist < R)
                filtered(a,b) = ft(a,b);
            end;
        end;
    end;
    filtered = ifftshift(filtered);
    inv = ifft2(filtered);
    inv = abs(inv);
    diff = (inv - img).^2;
    s = sum(sum(diff));
    rmsd = sqrt(s/(size(inv,1)*size(inv,2)));
    disp(['for radius: ' num2str(R) ' rmsd = ' num2str(rmsd)]);
end;
%{
for R = 50:70
    tmpenergy = 0;
    for i=1:r
        for j=1:c
            dist = sqrt((i-r/2)^2 + (j-c/2)^2);
            
            if(dist < R)
                tmpenergy = tmpenergy + abs(ft(i,j))^2;
            end;
        end;
    end;
    perc = (tmpenergy/energy)*100;
    disp(['for radius: ' num2str(R) ' energy = ' num2str(perc) '%']);
end;
%}
%disp(output);


toc;
