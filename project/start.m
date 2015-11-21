image = imread('data/img.jpg');
s = size(image);
image = floor(double(image)/8);
hist = zeros(32*32*32,1);
count = 0;
for i = 1:s(1)
    for j = 1:s(2)
        a = image(i,j,:);
        bin = a(1)*32*32 + a(2)*32 + a(3) + 1;
        hist(bin) = hist(bin)+1;
        
    end;
end;
    