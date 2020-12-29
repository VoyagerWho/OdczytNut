function subImage = CutOutImage(im, Corners)
%CUTOUTIMAGE Cutting out subimage from Corners
%   Cutting out part of image based on Corners of subimage
    beginX = int16(Corners(2));
    beginY = int16(Corners(1));
    endX = int16(Corners(4));
    endY = int16(Corners(3));
    subImage = im(beginY:endY, beginX:endX);
end

