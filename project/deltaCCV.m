function [ delta ] = deltaCCV(CV1,CV2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    if ~isequal(size(CV1),size(CV2))
        error('The dimensions of Coherence MAtrix donot match')
    end
    
    s = size(CV1);
    delta = zeros(s(1),1);
    for i = 1:s(1)
        delta(i) = abs(CV1(i,1)-CV2(i,1)) + abs(CV1(i,2)-CV2(i,2));
    end
    
end

