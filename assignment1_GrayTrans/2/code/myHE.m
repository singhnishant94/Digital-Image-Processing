function output = myHE(img)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
img = double(img);
M = size(img, 1);
N = size(img, 2);
channels = size(img, 3);
freq = zeros(256, channels);
output = double(zeros(M, N, channels));
cast(output, 'like', img);
for c = 1:channels
    for i = 1:M
        for j = 1:N
            freq(img(i, j, c) + 1, c) = freq(img(i, j, c) + 1, c) + 1;
        end;
    end;
end;
%disp(freq);
cumfreq = zeros(256, channels);
for c = 1:channels
    prev = 0;
    for i = 1:256
        cumfreq(i, c) = prev + freq(i, c);
        prev = cumfreq(i, c);
    end;
end;
prev = 0;

%disp(cumfreq);


for c = 1:channels
    for i = 1:M
        for j = 1:N
            output(i, j, c) = (cumfreq(img(i,j,c)+1, c)*255.0)/(M*N);
        end;
    end;
end;

output = output/255.0;
%disp(cumfreq(img(512, 512, 1)+1, 1)*img(512, 512, 1));
        
            

end

