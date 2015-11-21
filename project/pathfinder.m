function [path0, path1, path2, path3] = pathfinder( row )
%pathfinder Summary of this function goes here
%   This function finds the path of the image given its
%   index in the CCV gallery. The number of images for
%   each directory is known beforehand and therefore
%   the image location can be found out.

folder = './data/imagedatabase.cs.washington.edu/groundtruth/';
aus = strcat(folder, 'australia/');
arb = strcat(folder, 'arborgreens/');
iran = strcat(folder, 'iran/');
cam = strcat(folder, 'cambridge/');

narb = 47;
naus = 30;
ncam = 50;
niran = 49;

orig = row(1);
m1 = row(2);
m2 = row(3);
m3 = row(4);

    function path = help(num)
        t = num;
        if num <= narb
            tmp = strcat(arb, 'Image');
            if num < 10
                tmp = strcat(tmp, '0');
            end;
            path = strcat(tmp, num2str(num), '.jpg');
            
            return;
        end;
        num = num - narb;
        if num <= naus
            tmp = strcat(aus, 'Image');
            if num < 10
                tmp = strcat(tmp, '0');
            end;
            path = strcat(tmp, num2str(num), '.jpg');
            
            return;
        end;
        num = num - naus;
        if num <= ncam
            tmp = strcat(cam, '0');
            if num < 10
                tmp = strcat(tmp, '0');
            end;
            path = strcat(tmp, num2str(num), '.jpg');
            
            return;
        end;
        num = num - ncam;
        if num <= niran
            tmp = strcat(iran, 'Image');
            if num < 10
                tmp = strcat(tmp, '0');
            end;
            path = strcat(tmp, num2str(num), '.jpg');
            
            return;
        
        else
            disp('ERROR!!!!!!!!!!!');
            disp(t);
            path = '';
        end;
    end
    
    path0 = help(orig);
    path1 = help(m1);
    path2 = help(m2);
    path3 = help(m3);
    
    
end

