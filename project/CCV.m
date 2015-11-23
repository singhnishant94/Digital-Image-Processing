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
    avg_filt = fspecial('average');
    image = imfilter(image, avg_filt);
    image = floor(double(image)/factor);
    hist = zeros(antifactor*antifactor*antifactor,4);
    s = size(image);
    visited = zeros(s(1),s(2));
    xcenter = s(1)/2;
    ycenter = s(2)/2;
    radius = min(s(1),s(2)) * 0.4; % 0.4 means 80% of 0.5 which is finding the radius
    
    function [res] = iscenter(x,y)
       dis = sqrt((x-xcenter)*(x-xcenter) + (y-ycenter)*(y-ycenter)) ;
       res = dis < radius;
    end
    
    function  help(x,y,prevbin)
        if x < 1 || y < 1 || x > s(1) || y > s(2) || visited(x,y)==1
            return
        end;
        
        % To prevent maximum recursion limit
        if count == 490 
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
        if iscenter(x,y) == 1
            incenter = incenter+1;
        else
            outcenter = outcenter+1;
        end;
        
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
            incenter = 0;
            outcenter = 0;
            curbin = 0;
            help(i,j,0);
            if count == 0
                 continue;
            elseif count < THRESHOLD
                hist(curbin,1) = hist(curbin,1)+incenter;
                hist(curbin,2) = hist(curbin,2)+outcenter;
            else
                hist(curbin,3) = hist(curbin,3)+incenter;
                hist(curbin,4) = hist(curbin,4)+outcenter;
            end
        end
    end
    
    vector = hist;
    
end

