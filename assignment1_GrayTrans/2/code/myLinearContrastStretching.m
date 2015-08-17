function output = myLinearContrastStretching(img)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
img = double(img);
M = size(img, 1);
N = size(img, 2);
output = double(zeros(M, N, size(img, 3)));
cast(output, 'like', img);

maxpix = [0.0,0.0,0.0];
minpix = [255.0, 255.0, 255.0];
for channel =1:size(img,3)
    for i=1:M
        for j=1:N
            maxpix(channel) = max(maxpix(channel), img(i,j,channel));
            minpix(channel) = min(minpix(channel), img(i,j,channel));
        end;
    end;
end;
for channel = 1:size(img, 3)
    maxp = maxpix(channel);
    minp = minpix(channel);
    %disp(maxp);
    currange = maxp - minp;
    for i = 1:M
        for j = 1:N
            output(i, j, channel) = (img(i, j, channel)*255.0)/currange;
        end;
    end;
end;
output = output/255.0;
%disp(img);

end

