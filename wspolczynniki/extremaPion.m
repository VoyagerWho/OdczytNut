function wsp = extremaPion(im)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
ex = regionprops(im, "Extrema");

wsp = ex.Extrema(7, 1)-ex.Extrema(6, 1);
end

