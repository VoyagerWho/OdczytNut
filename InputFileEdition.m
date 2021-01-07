clear;clc;close all;

%im = double(rgb2gray(imread("Nuty/TestNowy_VOL2.jpg")))/255;
%im = double(rgb2gray(imread("Nuty/NutySkreslone.jpg")))/255;
im = double(rgb2gray(imread("Nuty/TestNew.jpg")/255));
im = ~imbinarize(im);
[h,w]=size(im);
imshow(im);

horBrightness = sum(double(im), 2);
figure;
plot(1:h,horBrightness);

horBrightTreshold = max(horBrightness)*0.9;
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
   Corners(i, 1) = max(posLines(5*(i-1)+1) - dist, 1);
   Corners(i, 2) = 1;
   Corners(i, 3) = min(posLines(5*i) + dist, h);
   Corners(i, 4) = w;
end


% Editing every staff seperatly in one for
% Can not guarantee identical sizes

[db, dbLen] = loadDatabase();

figure;
i=2;
% for i=1:numberOfStaffs
% podział na takty
    subplot(numberOfStaffs,1,i);
    CutOut = CutOutImage(filtered, Corners(i,:));
    imshow(CutOut);
    [hc, ~] = size(CutOut);
    verBrightness = sum(double(CutOut), 1);
    figure;
    plot(1:w,verBrightness);
    verBrightTreshold = hc*0.6;
    VposLines=[];
    % find()
    for j=1:w
       if verBrightness(j)>verBrightTreshold
          VposLines = [VposLines, j]; 
       end
    end
    for j = VposLines
        for k=1:hc
            CutOut(k,j-1) = 0;
            CutOut(k,j) = 0;
            CutOut(k,j+1) = 0;
        end
    end
    
    Symbols = regionprops(CutOut, 'Area','BoundingBox', 'Image', 'EulerNumber');

    figure;
    imshow(CutOut);
    title("bez pionowych");
    % analize the notes
    Notes = [];
    for j=1:length(Symbols)
        if(Symbols(j).Area > 10)
            Notes =[Notes; Classify(Symbols(j).Image, db, dbLen)];
        else
            Notes = [Notes; noteDesc(0, 'nil', 0, 0, 0, 0)];
        end
    end
    
    % find seperated notes and calculate height
    consolidateIndex=1;
    consolidateTab=zeros(length(Symbols), 1);
    for j=1:length(Symbols)-1
        if(Notes(j).Id == 0)
            
            for k=min(j+1, length(Symbols)):min(j+3, length(Symbols))
                if(Notes(k).Id == 0)
                    SepSymCor = ConnectSeperatedSymbols(Symbols, j:k);
                    SepSym = CutOutImage(CutOut, SepSymCor);
                    Notes(j) = Classify(SepSym, db, dbLen);
                   
                    if(Notes(j).Id ~= 0)
                        BBox = cornersToBBox( SepSymCor);
                        Notes(j).Height = CalculateHeight((posLines(1,(5*(i-1)+1):5*i)-Corners(i, 1)), Notes(j), BBox);
                        consolidateTab(j:k) = consolidateIndex;
                        consolidateIndex=consolidateIndex+1;
                        Notes(j+1:k) = Notes(j);
                        j=k+1;
                        break;
                    end
                    
                end
            end
        else               
       Notes(j).Height = CalculateHeight((posLines(1,(5*(i-1)+1):5*i)-Corners(i, 1)), Notes(j), Symbols(j).BoundingBox);
        end
    end

% kolorowanie
%-------------------------------------
colorClassifier(im, filtered,  Symbols, Notes);

% konsolidacja
%-------------------------------------
% erase trash before keys
% j=1;
% while((j<=length(Notes)) && (Notes(j).Id ~= 13 || Notes(j).Id ~= 14))
%     j=j+1;
% end
% Notes = Notes(j:end);
% consolidateTab = consolidateTab(j:end);
% remove rest of trash
%     indexes = find([Notes.Id] > 0);
%     Notes = Notes([Notes.Id] > 0);
%     consolidateTab = consolidateTab(indexes);
%     % remove extra copies
%     maxIdx = max(consolidateTab);
%     for j=1:maxIdx
%         groupB = find(consolidateTab == j,1, 'first');
%         groupE = find(consolidateTab == j,1, 'last');
%         Notes = [Notes(1:groupB); Notes(groupE+1:end)];
%         consolidateTab = [consolidateTab(1:groupB); consolidateTab(groupE+1:end)];
%     end
% height must be calculated at the same time as classification, because
% grouping will lose the bbox

% here goes toXml konwerter
% 
% 
% end
% figure;
% SepSymCor = ConnectSeperatedSymbols(Symbols, [2,3,4]); % reczne grupowanie
% SepSym = CutOutImage(CutOut, SepSymCor);
% imshow(SepSym);
% title("group test");
% group = Classify(SepSym, db, dbLen);
% figure;
% subplot(2,1,1);
% SepSymCor = ConnectSeperatedSymbols(Symbols, [6, 7]);
% SepSym = CutOutImage(CutOut, SepSymCor);
% imshow(imresize(SepSym, [128, 64]));
% subplot(2,1,2);
% imshow(getRecord(db, 1).Image);
% figure;
% sum(bitxor(imresize(Symbols(23).Image, [128, 64]), imrotate(getRecord(db, 15).Image, 180)), 'all')
% sum(bitxor(imresize(Symbols(23).Image, [128, 64]), getRecord(db, 27).Image), 'all')

for s=1:length(Symbols)
   subplot(5,6,s);
   imshow(imresize(Symbols(s).Image, [128, 64]));
end

% figure
% subplot(2,1,1)
% imshow(bitxor(imresize(Symbols(23).Image, [128, 64]), imrotate(getRecord(db, 15).Image, 180)))
% subplot(2,1,2)
% imshow(bitxor(imresize(Symbols(23).Image, [128, 64]), getRecord(db, 27).Image))

% wycinanie kresek
% [~, width]=size(im); 
% im(find(sum(im, 2) > width*0.8), :) = 0;


