function output = myShrinkImageByFactorD(img, d)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
newsize = floor(size(img,1)/d);
output = cast(zeros(newsize),'like',img);
for i = 1:newsize
    for j = 1:newsize
        output(i,j) = img(i*d, j*d);
    end;
end;
%disp(newimg);
%imwrite(output, '../images/result.png', 'png');
end

