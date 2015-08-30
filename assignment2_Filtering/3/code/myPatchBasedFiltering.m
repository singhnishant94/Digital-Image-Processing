function output = myPatchBasedFiltering( img, sigma_patch)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
patch_size = 9;
window_size = 27;
p_w = floor(patch_size/2);
w_w = floor(window_size/2);
rows = size(img, 1);
columns = size(img, 2);
output = double(zeros(size(img)));
iso = fspecial('gaussian', [patch_size patch_size], 1);

for i = 1:rows
    for j = 1:columns
        w_up = max(1, i-w_w);
        w_down = min(rows, i+w_w);
        w_left = max(1, j-w_w);
        w_right = min(columns, j+w_w);
        gauss_norm_mat = double(zeros(w_up, w_down));
        wind_sum = 0.0;
        new_pixval = 0.0;
        for k = w_up:w_down
            for l = w_left:w_right
                p_up = max(w_up, k-p_w);
                p_down = min(w_down, k+p_w);
                p_left = max(w_left, l-p_w);
                p_right = min(w_right, l+p_w);
                
                pp_up = p_up  + i - k;
                pp_down = p_down + i - k;
                pp_left = p_left + j - l;
                pp_right = p_right + j - l;
                
                wid_up = min([i-pp_up, k-p_up, i-w_up]);
                wid_down = min([pp_down-i, p_down-k, w_down-i]);
                wid_left = min([j-pp_left, l-p_left, j-w_left]);
                wid_right = min([pp_right-j, p_right-l, w_right-j]);
                
                p_up_f = k - wid_up;
                p_down_f = k + wid_down;
                p_left_f = l - wid_left;
                p_right_f = l + wid_right;
                
                pp_up_f = i - wid_up;
                pp_down_f = i + wid_down;
                pp_left_f = j - wid_left;
                pp_right_f = j + wid_right;
                
                iso_up = floor(patch_size/2) + 1 - wid_up;
                iso_down = floor(patch_size/2) + 1 + wid_down;
                iso_left = floor(patch_size/2) + 1 - wid_left;
                iso_right = floor(patch_size/2) + 1 + wid_right;
                
                
                %{
                disp(pp_up_f);
                disp(pp_down_f);
                disp(pp_left_f);
                disp(pp_right_f);
                disp('yes');
                %}
                
                
                patch_p = img([pp_up_f:pp_down_f], [pp_left_f:pp_right_f]);
                patch_q = img([p_up_f:p_down_f], [p_left_f:p_right_f]);
                
                
                iso_cur = iso([iso_up:iso_down], [iso_left:iso_right]);
                patch_p = patch_p.*iso_cur; % isotropising
                patch_q = patch_q.*iso_cur; % isotropising
                
                patch_diff = patch_q - patch_p;
                patch_diff = patch_diff.^2;
                norm = sum(sum(patch_diff));
                gauss_norm = exp(-norm/(sigma_patch^2));
                wind_sum = wind_sum + gauss_norm;
                new_pixval = new_pixval + img(k,l)*gauss_norm;
                %gauss_norm_mat(k,l) = gauss_norm;
            end;
        end;
        new_pixval = new_pixval/wind_sum;
        %window_sum = sum(sum(gauss_norm_mat));
        %{
        for k = w_up:w_down
            for l = w_left:w_right
                new_pixval = new_pixval + img(k,l)*gauss_norm_mat(k,l)/window_sum;
            end;
        end;
        %}
        output(i,j) = new_pixval;
    end;
end;
end

