load iran.mat;
load arborgreens.mat;
load cambridge.mat;
load australia.mat;
load gallery.mat;
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




match = zeros(size(gallery, 3), 3);
match = [];
count = 0;
%for i = 1 : size(gallery, 3)
occured = zeros(size(gallery, 3), 1);
while count < 26
    i = randi(size(gallery, 3));
    while occured(i) == 0
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
        curdelta = sum(deltaCCV(gallery(:,:,j), gallery(:,:,i)));
        if curdelta < mat(3, 2)
            mat(3,2) = curdelta;
            mat(3,1) = j;
        end;
    end;
    match = [match; [i mat(1,1) mat(2,1) mat(3,1)]];
end;

paths = [];
for i = 1:size(match, 1)
    [x1, x2, x3, x4] = pathfinder(match(i,:));
    %disp({x1, x2, x3, x4});
    paths = [paths; {x1 x2 x3 x4}];
end;

for i = 1:size(paths,1)
    figure;
    x = paths(i,:);
    
    
    
    subplot_tight(3,3,2), imshow(imread(x{1}));
    subplot_tight(3,3,4), imshow(imread(x{2}));
    subplot_tight(3,3,5), imshow(imread(x{3}));
    subplot_tight(3,3,6), imshow(imread(x{4}));
    %}
    
end;