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
% TODO: Lines with variable hight aka 2px high
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

[db, dbLen] = loadDatabase();

figure;
i=2;
%for i=1:numberOfStaffs
    subplot(numberOfStaffs,1,i);
    CutOut = CutOutImage(filtered, Corners(i,:));
    imshow(CutOut);
    verBrightness = sum(double(CutOut), 1);
    figure;
    plot(1:w,verBrightness);
    verBrightTreshold = max(verBrightness)*0.80;
    VposLines=[];
    for i=1:w
       if verBrightness(i)>verBrightTreshold
          VposLines = [VposLines, i]; 
       end
    end
    [hc, ~] = size(CutOut);
    for j = VposLines
        for i=1:hc
            CutOut(i,j-1) = 0;
            CutOut(i,j) = 0;
            CutOut(i,j+1) = 0;
        end
    end
    figure;
    imshow(CutOut);
    title("bez pionowych");
    Symbols = regionprops(CutOut, 'BoundingBox', 'Image');
    
    % analize the notes
    Notes = [];
    for j=1:length(Symbols)
        Notes =[Notes; Classify(Symbols(j).Image, db, dbLen)];
    end
%     for j=1:length(Symbols)
%         if(Notes(j).Id == 0)
%             for k=j+1:j+3
%                 if(Notes(k).Id == 0)
%                     SepSymCor = ConnectSeperatedSymbols(Symbols, j:k);
%                     SepSym = CutOutImage(CutOut, SepSymCor);
%                     Notes(j) = Classify(SepSym, db, dbLen);
%                     if(Notes(j).Id ~= 0)
%                         j=k+1;
%                         break;
%                     end
%                 end
%             end
%         end
%     end

% kolorowanie
%-------------------------------------

% konsolidacja
%-------------------------------------
    % for testing I will symulate it
    % Analized = AnalizeSymbols(Symbols)
%end
figure;
SepSymCor = ConnectSeperatedSymbols(Symbols, [3,4,5]); % reczne grupowanie
SepSym = CutOutImage(CutOut, SepSymCor);
imshow(SepSym);
group = Classify(SepSym, db, dbLen);
figure;
subplot(2,1,1);
imshow(imresize(Symbols(13).Image, [128, 128]));
subplot(2,1,2);
imshow(getRecord(db, 10).Image);
figure;
for i=1:16
   subplot(4,4,i);
   imshow(imresize(Symbols(i).Image, [128, 128]));
end



