function output = myBilinearInterpolation(img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

M = size(img, 1);
N = size(img, 2);
output = double(zeros(3*M-2, 2*N-1));
img = double(img);
cast(output, 'like', img);
for i = 1:M
    output(3*(i-1)+1, 1) = img(i, 1);
    for j = 2:N
        a = img(i,j-1);
        b = img(i,j);
        interp = a + (b-a)/2;
        output(3*(i-1)+1, 2*(j-1)) = interp;
        output(3*(i-1)+1, 2*j-1) = b;
    end;
end;

for j = 1:2*N-1
    for i = 2:M
        a = output(3*(i-2)+1, j);
        b = output(3*(i-1)+1, j);
        first = a + (b-a)/3;
        second = first + (b-a)/3;
        output(3*(i-2)+2, j) = first;
        output(3*(i-2)+3, j) = second;
    end;
end;
output = output/255.0;

        
end

