function [Ix, Iy, eigIm1, eigIm2, Corner] = myHarrisCornerDetector( img, sigma, k )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

gaussian = fspecial('gaussian', [3 3], sigma);

horMask = [-1 0 1; -2 0 2; -1 0 1];
verMask = [-1 -2 -1; 0 0 0; 1 2 1];

Ix = conv2(img, horMask, 'same');
Iy = conv2(img, verMask, 'same');
Ix2 = Ix.*Ix;
Iy2 = Iy.*Iy;
IxIy = Ix.*Iy;


A = conv2(Ix2, gaussian, 'same');
B = conv2(Iy2, gaussian, 'same');
C = conv2(IxIy, gaussian, 'same');


eigIm1 = double(zeros(size(img)));
eigIm2 = double(zeros(size(img)));
Corner = double(zeros(size(img)));

for i = 2:size(img,1)-1
    for j = 2:size(img,2)-1
        StrTen = [A(i,j) C(i,j); C(i,j) B(i,j)];
        eigVal = eig(StrTen);
        eigIm1(i,j) = eigVal(1);
        eigIm2(i,j) = eigVal(2);
        %Corner(i,j) = det(StrTen) - k*(trace(StrTen).^2);
        %{
        A = Ix2([i-1:i+1],[j-1:j+1]);
        B = Iy2([i-1:i+1],[j-1:j+1]);
        C = IxIy([i-1:i+1],[j-1:j+1]);
        A = A.*gaussian;
        B = B.*gaussian;
        C = C.*gaussian;
        e1 = sum(sum(A));
        e2 = sum(sum(B));
        e3 = sum(sum(C));
        StrTen = [e1 e3; e3 e2];
        eigV = eig(StrTen);
        eigIm1(i,j) = min(eigV);
        eigIm2(i,j) = max(eigV);
        Corner(i,j) = det(StrTen) - k*(trace(StrTen).^2);
        %}
    end;
end;


detM = A.*B - C.^2;
trM = A + B;
Corner = detM - k*(trM.^2);

disp(min(Corner(:)));
disp(max(Corner(:)));

%Corner = det(StrTen) - k*(trace(StrTen).^2);
%figure, imshow(imadjust(Corner));
%disp(C);


end

