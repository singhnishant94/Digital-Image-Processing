function output = myMeanShiftSegmentation(img, hs, hr, max_iter, window_size)
img = double(img);
sz = size(img);
output = zeros(sz);
[x, y] = meshgrid(1:sz(1), 1:sz(2));
img = cat(3, cat(3, img, x), y);

width = window_size/2;
for iter=1:max_iter
    
    for i=1:sz(1)
        for j=1:sz(2)
            up = min(width, i-1);
            down = min(width, sz(1)-i);
            left = min(width, j-1);
            right = min(width, sz(2)-j);
            
            patch = img(i-up:i+down, j-left:j+right, :);
            d1 = (patch(:,:,1) - img(i,j,1)).^2 + (patch(:,:,2) - img(i,j,2)).^2 + (patch(:,:,3) - img(i,j,3)).^2;
            d2 = (patch(:,:,4) - img(i,j,4)).^2 + (patch(:,:,5) - img(i,j,5)).^2;
            diff = d1(:,:)/(hr^2) + d2(:,:)/(hs^2);
            weights = exp(-diff);
            sum_weights = sum(sum(weights));
           
            for it=1:5
                img(i,j,it) = sum(sum(weights.*patch(:,:,it)))/sum_weights;
            end;
            
        end;
    end;
end;

for i=1:sz(1)
    for j=1:sz(2)
        for ch=1:3
            output(i,j,ch) = img(i,j,ch);
        end;
    end;
end;

        