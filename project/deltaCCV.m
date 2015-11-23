function [ delta ] = deltaCCV(CV1,CV2,type)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    if nargin < 3
        type = 0;
    end
    
    if ~isequal(size(CV1),size(CV2))
        error('The dimensions of Coherence MAtrix donot match')
    end
    
    s = size(CV1);
    delta = zeros(s(1),1);
    for i = 1:s(1)
        if type==0
            delta(i) = abs((CV1(i,1)+CV1(i,2))-(CV2(i,1)+CV2(i,2))) + abs((CV1(i,3)+CV1(i,4))-(CV2(i,3)+CV2(i,4)));
        elseif type==1
            delta(i) = abs((CV1(i,1)+CV1(i,2)+CV1(i,4)+CV1(i,4)) - (CV2(i,1)+CV2(i,2)+CV2(i,4)+CV2(i,4)));
        else
            delta(i) = abs(CV1(i,1)-CV2(i,1)) + abs(CV1(i,2)-CV2(i,2)) + abs(CV1(i,3)-CV2(i,3)) + abs(CV1(i,4)-CV2(i,4));
        end;
    end
    
end

