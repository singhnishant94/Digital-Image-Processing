function output = myCLAHE( img, N, t )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
r = size(img, 1);
c = size(img, 2);
channels = size(img, 3);
img = double(img);
output = double(zeros(r, c, channels));
cast(output, 'like', img);
for ch = 1:channels
    for i = 1:r
        freq = double(zeros(256));
        prevleftcol = 1;
        prevrightcol = 1;
        total = 0;
        for j = 1:c
            
            a = floor(N/2);
            b = floor((N+1)/2);
            leftcol = max(1, (j-b+1));
            rightcol = min(c, (j+a));
            top = max(1, (i-b+1));
            bottom = min(r, (i+a));
            
            if j==1
                for ii = top:bottom
                    for jj = leftcol:rightcol
                        freq(img(ii, jj, ch) + 1) = freq(img(ii, jj, ch) + 1) + 1;
                        total = total + 1;
                    end;
                end;
            else
                if(leftcol > prevleftcol)
                    for temprow = top:bottom
                        freq(img(temprow, prevleftcol, ch) + 1) = freq(img(temprow, prevleftcol, ch) + 1) - 1;
                        total = total - 1;
                    end;
                end;
                if(rightcol > prevrightcol)
                    for temprow = top:bottom
                        freq(img(temprow, rightcol, ch) + 1) = freq(img(temprow, rightcol, ch) + 1) + 1;
                        total = total + 1;
                    end;
                end;
            end;
            prevleftcol = leftcol;
            prevrightcol = rightcol;
            prev = 0;
            cumfreq = zeros(256);
            extra = 0;
            thres = t*total;
            %disp(total);
            for iter = 1:256
                if(freq(iter) > thres)
                    extra = extra + freq(iter) - thres;
                    freq(iter) = thres;
                end;
            end;
            for iter = 1:256
                freq(iter) = freq(iter) + extra/256.0;
            end;
            
            for iter = 1:256
                cumfreq(iter) = prev + freq(iter);
                prev = cumfreq(iter);
            end;
            
            %disp(freq(255));
            %disp(total);
            output(i, j, ch) = (cumfreq(img(i,j,ch)+1)*255.0)/total;
        end;
    end;
end;


%output = uint8(output);
output = output/255.0;
%disp(output);
                
            
            

end

