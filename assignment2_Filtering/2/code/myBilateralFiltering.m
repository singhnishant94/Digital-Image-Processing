function output = myBilateralFiltering( img, sigma_d, sigma_r )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
M = 9;
rows = size(img, 1);
columns = size(img, 2);
output = double(zeros(size(img)));

w = floor(M/2);

[X,Y] = meshgrid(-w:w, -w:w);
G = exp(-(X.^2 + Y.^2)/(2*sigma_d^2));
%disp(G);

for i = 1:rows
    for j = 1:columns
        row_up = max(1, i-w);
        row_down = min(rows, i+w);
        col_left = max(1, j-w);
        col_right = min(columns, j+w);
        I_mat = img([row_up:row_down],[col_left:col_right]);
        H = exp(-(I_mat-img(i,j)).^2/(2*sigma_r^2));
        
        F = H.*G((row_up:row_down)-i+w+1, (col_left:col_right)-j+w+1);
        output(i,j) = sum(F(:).*I_mat(:))/sum(F(:));
   
    end;
end;

end

