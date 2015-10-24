%% MyMainScript

tic;
%% The value of k
karr = [1, 2, 3, 5, 10, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];

%% Fetching the images
root = uigetdir;
root = strcat(root, '/');
%disp(root);
X = [];
test = [];
r=0;
c=0;
%root = '/home/nishant/Acads/Sem7/DIP/assignments/CroppedYale/';

%delete(h);
disp('Reading database');

N = 38*30;

for i=1:39
    
    yale = 'yaleB';
    if i==14
        continue;
    end;
    if i<10
        yale = strcat(yale, '0');
    end;
    yale = strcat(yale, num2str(i));
    persondir = strcat(root, yale);
    %disp(persondir);
    pgms = strcat(persondir, '/*.pgm');
    imgs = dir(pgms);
    
    for it=1:30
        %waitbar((i*30+it)/390);
        imgname = imgs(it).name;
        imgpath = strcat(persondir, '/', imgname);
        img = imread(imgpath);
        [r,c] = size(img);
        img = reshape(img', r*c, 1);
        X = [X img];
    end;
    for it=31:60
        %waitbar((i*30+it)/390);
        imgname = imgs(it).name;
        imgpath = strcat(persondir, '/', imgname);
        img = imread(imgpath);
        [r,c] = size(img);
        img = reshape(img', r*c, 1);
        test = [test img];
    end;
end;
disp('Database fetched');
%disp(size(X));

disp('Performing required computations');

%% Computing the mean and subtracting it from each point
m = mean(X, 2);
A = bsxfun(@minus, double(X), m(:,1));

%% Computation of co-variance matrix
L = A'*A;
[W,D] = eigs(L, N);

%% Obtaining eigenvectors of C from those of L
V = A*W;

%% Unit-normalizing V
V = normc(V);

%% Picking eigenvectors corresponding to top k eigenvalues

rates = zeros(size(karr));
rates1 = zeros(size(karr));

disp('Recognizing the test images');
h = waitbar(0, 'Performing recognition..');

EVtmp = V'*A;

for kind=1:size(karr,2)
    
    k = karr(kind);
    %thres = T(k+3);

    EV = V(:, 4:k+4);
    EV1 = V(:, 1:k);
    
    
    %% Projecting each point onto the eigenspace
    %projected = EV'*A;
    projected = EVtmp(4:k+4,:);
    projected1 = EVtmp(1:k,:);
    %figure;
    tot1 = 13;
    tot2 = 39-tot1;
    tot = 39;
    
    %mindistarr = [];
    recognized = 0;
    recognized1 = 0;
    total = (tot-1)*30;
    totcount = 1;
    for p=1:tot
        %waitbar((kind*38)/(size(karr,2)*38));
        
        if p==14
            continue;
        end;
        
        for it=31:60
            testvec = test(:, totcount);
            totcount = totcount + 1;
            testvec = double(testvec)-m;
            
            projtest = EV'*testvec;
            ind = dsearchn(projected', projtest');
            person = ceil(ind/30);
            
            if person >= 14
                person = person + 1;
            end;
            
            imgind = rem(ind,30)+1;
            if person==p
                recognized=recognized+1;
            end;
            
            
            projtest = EV1'*testvec;
            ind = dsearchn(projected1', projtest');
            person = ceil(ind/30);
            
            if person >= 14
                person = person + 1;
            end;
            imgind = rem(ind,30)+1;
            if person==p
                recognized1=recognized1+1;
            end;            
        end;
    end;

    rates(kind) = double(recognized*100.0/total);
    rates1(kind) = double(recognized1*100.0/total);
    waitbar(kind/size(karr,2));
end;
delete(h);
disp(rates);
disp(rates1);
figure, plot(karr, rates), xlabel('k'), ylabel('% recognition rate'), title('Recognition rate vs. k after removing top 3 eigenvectors');
figure, plot(karr, rates1), xlabel('k'), ylabel('% recognition rate'), title('Recognition rate vs. k');

toc;