function wsp = extremaPoziom(im)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
ex = regionprops(im, "Extrema");

wsp = ex.Extrema(2, 2)-ex.Extrema(3, 2);
end

