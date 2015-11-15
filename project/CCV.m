function [vector] = CCV(image_name,factor,THRESHOLD)
    %CCV This function calculates the Color Coherence Vector for a given
    %Image
    %   It takes an input name and a factor which is bydefault 8
    if nargin < 2
        factor = 8;
    end
    
    if nargin < 3
        THRESHOLD = factor * 2;
    end
    
    antifactor = floor(256/factor);
    if factor * antifactor ~= 256
       error('Factor must be a power of 2 and less than 256')
    end
    
    vector=[];
    if exist(image_name, 'file') ~= 2
        return;
    end;
    image = imread(image_name);
    image = floor(double(image)/factor);
    hist = zeros(antifactor*antifactor*antifactor,2);
    s = size(image);
    visited = zeros(s(1),s(2));

   
    function  help(x,y,prevbin)
        if x < 1 || y < 1 || x > s(1) || y > s(2) || visited(x,y)==1
            return
        end;
        bin = calcbin(x,y);
        curbin = bin;
        if prevbin ~= bin && prevbin ~=0
            return
        end;
        %disp([x,y,count,bin])
        visited(x,y)=1;
        count = count + 1;
        help(x+1,y,bin);
        help(x-1,y,bin);
        help(x,y+1,bin);
        help(x,y-1,bin);
    end

    function [bin] = calcbin(x,y)
        a = image(x,y,:);
        bin = a(1)*antifactor*antifactor + a(2)*antifactor + a(3) + 1;
        %disp([x,y,a(1),a(2),a(3),bin]);
    end

    
    
    for i = 1:s(1)
        for j = 1:s(2)
            count = 0;
            curbin = 0;
            help(i,j,0);
            if count == 0
                 continue;
            elseif count < THRESHOLD
                hist(curbin,1) = hist(curbin,1)+count;
            else
                hist(curbin,2) = hist(curbin,2)+count;
            end
        end
    end
    
    vector = hist;
    
end

