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
for i=1:40
    personDir = strcat(root,'/s',num2str(i));
    if i <= 35
        for j=1:5
            imgpath = strcat(personDir, '/', num2str(j), '.pgm');
            img = imread(imgpath);

            [r, c] = size(img);
            img = reshape(img', r*c, 1);
            X = [X img];
        end;
    end;
    for j=6:10
        imgpath = strcat(personDir, '/', num2str(j), '.pgm');
        img = imread(imgpath);
        
        [r, c] = size(img);
        img = reshape(img', r*c, 1);
        test = [test img];
    end;
    if i>35
        for j=1:10
            imgpath = strcat(personDir, '/', num2str(j), '.pgm');
            img = imread(imgpath);

            [r, c] = size(img);
            img = reshape(img', r*c, 1);
            test = [test img];
        end;
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
falsenegs = zeros(size(karr));
falseposs = zeros(size(karr));

disp('Calculating recognition rates on test images');
netmax = -1;
thres = 4100;
%{ 
Setting the threshold value for determining if there is a match or not.
If the distance between the two vectors is greater than this threshold, 
we say that there is no match found in the database. 
This number has been found out by determining the maximum of the minimum
distances for the test images whose identity was present in the database.
So there won't be a case of false negative. That is there won't be any
person who despite being present in the database won't be recognized.

However for the cases when the person is not in the database, sometimes
the distance can be less than threshold and the algorithm would
successfully recognize that person. This is the case of false positive.

Increasing the value of the threshold would mean a decrease in the number 
of false positives for the test images whose identity is not present in 
the database.
%}
    


for kind=1:size(karr,2)
    k = karr(kind);
    
    EV = V(:,1:k);
    
    
    %% Projecting each point onto the eigenspace
    
    projected = EV'*A;
    
    tot = 40;
    
    
    recognized = 0;
    total = 35*5;
    count = 1;
    falsepos = 0;
    falseneg = 0;
    for p=1:tot
        if p <= 35
            for it=1:5
                testvec = test(:, count);
                %testvec = test(:, (p-1)*5+it);
                count = count+1;
                testvec = double(testvec)-m;

                projtest = EV'*testvec;

                ind = dsearchn(projected', projtest'); 

                minval = norm(projected(:,ind) - projtest, 2);
                
                %disp(minval);

                person = ceil(ind/5);
                imgind = rem(ind,5)+1;

                if person==p
                    if minval < thres
                        recognized=recognized+1;
                    else
                        falseneg = falseneg + 1;
                    end;
                end;
            end;
        else
            for it=1:10
                testvec = test(count);
                count = count+1;
                testvec = double(testvec)-m;

                projtest = EV'*testvec;

                ind = dsearchn(projected', projtest'); 

                minval = norm(projected(:,ind) - projtest, 2);

                %disp(minval);

                %person = ceil(ind/5);
                imgind = rem(ind,5)+1;
                if minval < thres
                    falsepos = falsepos + 1;
                end;
            end;
        end;
    end;
    
    rates(kind) = double(recognized*100.0/total);
    falsenegs(kind) = falseneg;
    falseposs(kind) = falsepos;
end;
disp(netmax);

disp(rates);
disp('False positives vs k');
disp(falseposs);
disp('False negatives vs k');
disp(falsenegs);
figure, plot(karr, rates), xlabel('k'), ylabel('% recognition rate'), title('Recognition rate vs. k');

toc;
