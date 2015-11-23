function [path0, path1, path2, path3, path4, path5, path6, path7, path8, path9] = pathfinder( row )
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
m4 = row(5);
m5 = row(6);
m6 = row(7);
m7 = row(8);
m8 = row(9);
m9 = row(10);

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
    path4 = help(m4);
    path5 = help(m5);
    path6 = help(m6);
    path7 = help(m7);
    path8 = help(m8);
    path9 = help(m9);
    
    
end

