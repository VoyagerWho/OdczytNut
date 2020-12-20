function p = perim(im)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
p = regionprops(im, "Perimeter").Perimeter;
end

