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
% TODO: Lines with variable height aka 2px high
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
    [hc, ~] = size(CutOut);
    verBrightness = sum(double(CutOut), 1);
    figure;
    plot(1:w,verBrightness);
    verBrightTreshold = hc*0.5;
    VposLines=[];
    for i=1:w
       if verBrightness(i)>verBrightTreshold
          VposLines = [VposLines, i]; 
       end
    end
    for j = VposLines
        for i=1:hc
            CutOut(i,j-1) = 0;
            CutOut(i,j) = 0;
            CutOut(i,j+1) = 0;
        end
    end
    
    Symbols = regionprops(CutOut, 'Area','BoundingBox', 'Image');
    
    
    figure;
    imshow(CutOut);
    title("bez pionowych");
    % analize the notes
    Notes = [];
    for j=1:length(Symbols)
        if(Symbols(j).Area > 10)
            Notes =[Notes; Classify(Symbols(j).Image, db, dbLen)];
        else
            Notes = [Notes; noteDesc(0, 'nil', 0, 0)];
        end
    end
    % find seperated notes and calculate height
    for j=1:length(Symbols)-1
        consolidateIndex=1;
        consolidateTab=zeros(length(Symbols), 1);
        if(Notes(j).Id == 0)
            for k=min(j+1, length(Symbols)):min(j+3, length(Symbols))
                if(Notes(k).Id == 0)
                    SepSymCor = ConnectSeperatedSymbols(Symbols, j:k);
                    SepSym = CutOutImage(CutOut, SepSymCor);
                    Notes(j) = Classify(SepSym, db, dbLen);
                    if(Notes(j).Id ~= 0)
                        Notes(j).Height = CalculateHeightGroup(posLines((i-1)*5+1:i*5),Notes(j), SepSymCor);
                        consolidateTab(j:k) = consolidateIndex;
                        consolidateIndex=consolidateIndex+1;
                        Notes(j+1:k) = Notes(j);
                        j=k+1;
                        break;
                    end
                end
            end
        else
            Notes(j).Height = CalculateHeight(posLines((i-1)*5+1:i*5),Notes(j), Symbols(j).BoundingBox);
        end
    end

% kolorowanie
%-------------------------------------

% konsolidacja
%-------------------------------------
% erase trash before keys
i=1;
while((i<=length(Notes)) && (Notes(i).Id ~= 13 || Notes(i).Id ~= 14))
    i=i+1;
end
Notes = Notes(i:end);
consolidateTab = consolidateTab(i:end);
% remove rest of trash
indexes = find([Notes.Id] > 0);
Notes = Notes([Notes.Id] > 0);
consolidateTab = consolidateTab(indexes);
% remove extra copies
maxIdx = max(consolidateTab);
for i=1:maxIdx
    groupB = find(consolidateTab == i,1, 'first');
    groupE = find(consolidateTab == i,1, 'last');
    Notes = [Notes(1:groupB); Notes(groupE+1:end)];
    consolidateTab = [consolidateTab(1:groupB); consolidateTab(groupE+1:end)];
end
% height must be calculated at the same time as classification, because
% grouping will lose the bbox

% here goes toXml konwerter


%end
figure;
SepSymCor = ConnectSeperatedSymbols(Symbols, [2,3,4]); % reczne grupowanie
SepSym = CutOutImage(CutOut, SepSymCor);
imshow(SepSym);
title("group test");
group = Classify(SepSym, db, dbLen);
figure;
subplot(2,1,1);
imshow(imresize(Symbols(13).Image, [128, 128]));
subplot(2,1,2);
imshow(getRecord(db, 14).Image);
figure;
for i=1:16
   subplot(4,4,i);
   imshow(imresize(Symbols(i).Image, [128, 128]));
end



