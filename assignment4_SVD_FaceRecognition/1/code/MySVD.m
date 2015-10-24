function [ U, S, V ] = MySVD( A )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
sz = size(A);

M = A*A';
N = A'*A;

[U, D] = eigs(M, sz(1));
[V, E] = eigs(N, sz(2));



m = sz(1);
n = sz(2);

if m<n
    S = sqrt(D);
    tmp = zeros(m, n-m);
    S = [S, tmp];
else
    S = sqrt(E);
    tmp = zeros(m-n, n);
    S = [S; tmp];
end;



end

