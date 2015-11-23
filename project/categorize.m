%{
This script performs the categorization of an input image based on
its CCV and how it compares with the images in the database.
The CCV of the database has been precomputed and saved in
gallery.mat. A few random images are then picked from the 
same database and we match the test image's CCV with those
present in the database except with the test image itself.
We find the top 3 matches and output them as images.
%}

load iran.mat;
load arborgreens.mat;
load cambridge.mat;
load australia.mat;
folder = './data/imagedatabase.cs.washington.edu/groundtruth/';
aus = strcat(folder, 'australia/');
arb = strcat(folder, 'arborgreens/');
bar = strcat(folder, 'barcelona/barcelona');
cam = strcat(folder, 'cambridge');



szira = size(iran, 3);
szaus = size(australia, 3);
szarb = size(arborgreens, 3);
szcam = size(cambridge, 3);
gallery = [];

for i = 1:size(arborgreens, 3)
    gallery = cat(3, gallery, arborgreens(:,:,i));
end;
for i = 1:size(australia, 3)
    gallery = cat(3, gallery, australia(:,:,i));
end;
for i = 1:size(cambridge, 3)
    gallery = cat(3, gallery, cambridge(:,:,i));
end;
for i = 1:size(iran, 3)
    gallery = cat(3, gallery, iran(:,:,i));
end;




match = [];
count = 0;
%for i = 1 : size(gallery, 3)
occured = zeros(size(gallery, 3), 1);
while count < 26
    i = randi(size(gallery, 3));
    while occured(i) == 1
        i = randi(size(gallery, 3));
        occured(i) = 1;
    end;
    
    count = count + 1;
    
    mindelta = 100000000;
    ind = -1;
    mat = [ind mindelta; ind mindelta; ind mindelta];
    for j = 1 : size(gallery,3)
        if i == j
            continue;
        end;
        mat = sortrows(mat, 2);
        curdelta = sum(deltaCCV(gallery(:,:,j), gallery(:,:,i),0));
        if curdelta < mat(3, 2)
            mat(3,2) = curdelta;
            mat(3,1) = j;
        end;
    end;
    mat1 = mat;
    
    mindelta = 100000000;
    ind = -1;
    mat = [ind mindelta; ind mindelta; ind mindelta];
    for j = 1 : size(gallery,3)
        if i == j
            continue;
        end;
        mat = sortrows(mat, 2);
        curdelta = sum(deltaCCV(gallery(:,:,j), gallery(:,:,i),1));
        if curdelta < mat(3, 2)
            mat(3,2) = curdelta;
            mat(3,1) = j;
        end;
    end;
    mat2 = mat;
    
    mindelta = 100000000;
    ind = -1;
    mat = [ind mindelta; ind mindelta; ind mindelta];
    for j = 1 : size(gallery,3)
        if i == j
            continue;
        end;
        mat = sortrows(mat, 2);
        curdelta = sum(deltaCCV(gallery(:,:,j), gallery(:,:,i),2));
        if curdelta < mat(3, 2)
            mat(3,2) = curdelta;
            mat(3,1) = j;
        end;
    end;
    mat3 = mat;
    
    match = [match; [i mat1(1,1) mat1(2,1) mat1(3,1) mat2(1,1) mat2(2,1) mat2(3,1) mat3(1,1) mat3(2,1) mat3(3,1)]];
end;

paths = [];
for i = 1:size(match, 1)
    [x1, x2, x3, x4,x5,x6,x7,x8,x9,x10] = pathfinder(match(i,:));
    %disp({x1, x2, x3, x4});
    paths = [paths; {x1 x2 x3 x4 x5 x6 x7 x8 x9 x10}];
end;

fileID = fopen('celldata.dat','w');
formatSpec = '%s %s %s %s %s %s %s %s %s %s\n';
for i = 1:size(paths,1)
    %figure;
    x = paths(i,:);
    
    
    
    %{
    subplot_tight(3,3,2), imshow(imread(x{1}));
    subplot_tight(3,3,4), imshow(imread(x{2}));
    subplot_tight(3,3,5), imshow(imread(x{3}));
    subplot_tight(3,3,6), imshow(imread(x{4}));
    %}
    fprintf(fileID,'%s',x{1});
    fprintf(fileID,' %s',x{2});
    fprintf(fileID,' %s',x{3});
    fprintf(fileID,' %s',x{4});
    fprintf(fileID,' %s',x{5});
    fprintf(fileID,' %s',x{6});
    fprintf(fileID,' %s',x{7});
    fprintf(fileID,' %s',x{8});
    fprintf(fileID,' %s',x{9});
    fprintf(fileID,' %s',x{10});
    fprintf(fileID,'\n');
    
    
end;
