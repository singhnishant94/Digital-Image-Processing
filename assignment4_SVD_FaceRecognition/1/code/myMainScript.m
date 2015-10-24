%% MyMainScript

tic;
%% Your code here
% input the function is the matrix A
% output is a set of three matrices U, S and V
A = [1,2,3; 4,5,6; 7,8,9;];% 10,11,12];
disp(A);
[U,S, V]= MySVD(A); 
disp('U: ');
disp(U);
disp('S: ');
disp(S);
disp('V: ');
disp(V);
disp('USVt');
disp(U*S*V');

toc;