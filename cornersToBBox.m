function x = cornersToBBox(SepSymCor)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    left = SepSymCor(2);
     top = SepSymCor(1);
    width = SepSymCor(4) - left;
    height = SepSymCor(3)-top;
    
    x = [left top width height];
                        
end

