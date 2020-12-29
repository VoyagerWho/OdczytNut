clear;clc;close all;

im = double(rgb2gray(imread("Nuty/UCZENIE.jpg")/255));
im = ~imbinarize(im);
[h,w]=size(im);
imshow(im);

horBrightness = sum(double(im), 2);
figure;
plot(1:h,horBrightness);

horBrightTreshold = max(horBrightness)*0.99;
posLines=[];
for i=1:h
   if horBrightness(i)>horBrightTreshold
      posLines = [posLines, i]; 
   end
end

% Note: Lines must be 1px high
% TODO: Lines with variable hight
filtered = ClearWithFilterUD(im, posLines, [0;1;0]);

dist = (posLines(6) - posLines(5))/2.0;

numberOfLines = length(posLines);
numberOfStaffs = numberOfLines/5;
Corners = zeros(numberOfStaffs, 4);
for i=1:numberOfStaffs
   Corners(i, 1) = posLines(5*(i-1)+1) - dist;
   Corners(i, 2) = 1;
   Corners(i, 3) = posLines(5*i) + dist;
   Corners(i, 4) = w;
end


% Editing every staff seperatly in one for
% Can not guarantee identical sizes

figure;
for i=1:numberOfStaffs
    subplot(numberOfStaffs,1,i);
    CutOut = CutOutImage(filtered, Corners(i,:));
    imshow(CutOut);
    
    Symbols = regionprops(CutOut, 'BoundingBox', 'Image');
    
    % analize the notes
    
    % for testing I will symulate it
    % Analized = AnalizeSymbols(Symbols)
end

figure;
SepSymCor = ConnectSeperatedSymbols(Symbols, [3,4,5,6,7]);
SepSym = CutOutImage(CutOut, SepSymCor);
imshow(SepSym);




