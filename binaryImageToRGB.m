function colored= binaryImageToRGB(bin, R,G,B)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

colored = cat(3, bin * R, bin * G, bin * B);

end

