function dispimage ( im, im_title, color_scale, map )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
figure, imshow(im), axis on, title(im_title, 'Fontsize', 11), colormap(color_scale), colormap(map), truesize, colorbar;

end

