%% MyMainScript

tic;
%% The value of k
karr = [1, 2, 3, 5, 10, 20, 30, 50, 75, 100, 125, 150, 170];

%% Fetching the images and reshaping them
root = uigetdir;
%root = '/home/nishant/Acads/Sem7/DIP/assignments/att_faces';
disp(root);
X = [];
%img = [];
r = 0;
c = 0;
disp('Reading the database..');

test = [];
N = 35*5;
for i=1:35
    personDir = strcat(root,'/s',num2str(i));
    for j=1:5
        imgpath = strcat(personDir, '/', num2str(j), '.pgm');
        img = imread(imgpath);
        
        [r, c] = size(img);
        img = reshape(img', r*c, 1);
        X = [X img];
    end;
    for j=6:10
        imgpath = strcat(personDir, '/', num2str(j), '.pgm');
        img = imread(imgpath);
        
        [r, c] = size(img);
        img = reshape(img', r*c, 1);
        test = [test img];
    end;
end;

%% Computing the mean and subtracting it from each point

disp('Performing computations');

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

disp('Calculating recognition rates on test images');
for kind=1:size(karr,2)
    k = karr(kind);
    
    EV = V(:,1:k);
    
    
    %% Projecting each point onto the eigenspace
    
    projected = EV'*A;
    
    tot = 35;
    
    
    recognized = 0;
    total = tot*5;
    for p=1:tot
    
        for it=1:5
            testvec = test(:, (p-1)*5+it);
            testvec = double(testvec)-m;

            projtest = EV'*testvec;
            
            ind = dsearchn(projected', projtest'); 
   
            person = ceil(ind/5);
            imgind = rem(ind,5)+1;
            
            if person==p
                recognized=recognized+1;
            end;
        end;
    end;
    
    rates(kind) = double(recognized*100.0/total);
end;

disp(rates);
figure, plot(karr, rates), xlabel('k'), ylabel('% recognition rate'), title('Recognition rate vs. k');

toc;
