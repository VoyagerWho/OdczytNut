clear;clc;close all;
filename = "TestNowy_VOL2.jpg"; % "TestNowy_VOL2.jpg" "/materiały_dydaktyczne/UCZENIE.jpg" "TestNew.jpg"
folder = "Nuty/";
%im = double(rgb2gray(imread("Nuty/TestNowy_VOL2.jpg")))/255;
%im = double(rgb2gray(imread("Nuty/NutySkreslone.jpg")))/255;
im = double(rgb2gray(imread(folder+filename)/255));
colorIm = cat(3, im, im, im);
im = ~imbinarize(im); 
[h,w]=size(im);
imshow(im);
title("Original");

%---------------------------------------------------
% Finding lines of staffs
%---------------------------------------------------
horBrightness = sum(double(im), 2);
figure;
plot(1:h,horBrightness, '.');
title("Horizontal Brightness");

horBrightTreshold = max(horBrightness)*0.8;
posLines=find(horBrightness>horBrightTreshold);


% Note: Lines must be 1px high
% TODO: Lines with variable height aka 2px high
% IDEA: Remove single line 1px wide
filtered = ClearWithFilterUD(im, posLines', [0;1;0]);
%---------------------------------------------------


%---------------------------------------------------
% Designating corners of staffs' image area
%---------------------------------------------------
dist = round((posLines(6) - posLines(5))/2.0);
numberOfLines = length(posLines);
numberOfStaffs = numberOfLines/5;
Corners = zeros(numberOfStaffs, 4);
for i=1:numberOfStaffs
   Corners(i, 1) = max(posLines(5*(i-1)+1) - dist, 1);
   Corners(i, 2) = 1;
   Corners(i, 3) = min(posLines(5*i) + dist, h);
   Corners(i, 4) = w;
end
%---------------------------------------------------


[db, dbLen] = loadDatabase();
NotesDB = [];
%---------------------------------------------------
% Main loop
% Editing every staff seperatly in one for
% Can not guarantee identical sizes
%---------------------------------------------------
%i=2;
for i=1:numberOfStaffs
    
    CutOut = CutOutImage(filtered, Corners(i,:));
    figure;
    imshow(CutOut);
    title("Stuff number: (" + i + ")");
    [hc, ~] = size(CutOut);


    %---------------------------------------------------
    % First method of sepereting measures
    % Easier but doesn't work with single staff
    % NOTE: left for reference
    %---------------------------------------------------
    %     verBrightness = sum(double(CutOut), 1);
    %     figure;
    %     plot(1:w,verBrightness);
    %     verBrightTreshold = hc*0.6;
    %     VposLines=find(verBrightness>verBrightTreshold);
    %     for j = VposLines
    %         for k=1:hc
    %             CutOut(k,j-1) = 0;
    %             CutOut(k,j) = 0;
    %             CutOut(k,j+1) = 0;
    %         end
    %     end
    %---------------------------------------------------
    Symbols = regionprops(CutOut, 'Area','BoundingBox', 'Image', 'EulerNumber');
    
    %---------------------------------------------------
    % Second method of sepereting measures
    % Uses ratio between w and h of Symbols' BBox
    %---------------------------------------------------
    for j=1:length(Symbols)
        Symbols(j).Linear = Symbols(j).BoundingBox(3)/Symbols(j).BoundingBox(4);
    end
    linearRatio = 0.15;
    temp = Symbols([Symbols.Linear] < linearRatio);
    verLines = zeros(length(temp), 1);
    for j=1:length(temp)
        verLines(j) = temp(j).BoundingBox(1);
    end
    %---------------------------------------------------
    
    
    
    %---------------------------------------------------
    % First classification designed for single symbols
    % Clears of small artifacts
    %---------------------------------------------------
    tabDifferences = zeros(dbLen, length(Symbols));
    Notes=repmat(noteDesc(0, 'nil', 0, 0, 0, 0), 1, 1 );
    for j=1:length(Symbols)
        if(Symbols(j).Area > 10)
            if(Symbols(j).Linear < linearRatio)
                Notes(j)= noteDesc(-1, 'measure', 0, 0, 0, 0);
                tabDifferences(:, j) = 128*64;
            else
                [Notes(j), tabDifferences(:, j)]= Classify(Symbols(j).Image, db, dbLen, 1.0);
            end
        else
            Notes(j)= noteDesc(0, 'nil', 0, 0, 0, 0);
            tabDifferences(:, j) = 128*64;
        end
    end
    %---------------------------------------------------
    
    
    %---------------------------------------------------
    % Second classification designed for seperated symbols
    % Connects neighbours to find notes
    %---------------------------------------------------
    consolidateIndex=1;
    consolidateTab=zeros(length(Symbols), 1);
    tabConDif = zeros(dbLen, length(Symbols));
    measureNumber=0;
    for j=1:length(Symbols)-1
        if(Notes(j).Id == 0)
            for k=min(j+1, length(Symbols)):min(j+3, length(Symbols))
                if(Notes(k).Id == 0)
                    SepSymCor = ConnectSeperatedSymbols(Symbols, j:k);
                    SepSym = CutOutImage(CutOut, SepSymCor);
                    [Notes(j), tabConDif(:, j)] = Classify(SepSym, db, dbLen, 1.0);
                   
                    if(Notes(j).Id ~= 0)
                        BBox = cornersToBBox(SepSymCor);
                        Notes(j).Height = CalculateHeight((posLines((5*(i-1)+1):5*i)-Corners(i, 1)), Notes(j), BBox);
                        Notes(j).Staff = i;
                        Notes(j).Measure = measureNumber;
                        consolidateTab(j:k) = consolidateIndex;
                        consolidateIndex=consolidateIndex+1;
                        Notes(j+1:k) = Notes(j);
                        for l=j+1:k
                            tabConDif(:, l) = tabConDif(:, j);
                        end
                        j=k+1;
                        break;
                    end
                else
                    break;
                end
            end
        else               
            Notes(j).Height = CalculateHeight((posLines((5*(i-1)+1):5*i)-Corners(i, 1)), Notes(j), Symbols(j).BoundingBox);
            Notes(j).Staff = i;
            if(Notes(j).Id == -1)
                measureNumber = measureNumber + 1;
            end
            Notes(j).Measure = measureNumber;
        end
    end
    %---------------------------------------------------
    
    
    %---------------------------------------------------
    % Colouring for visual purposes
    %---------------------------------------------------
    % staffs
    temp=bitxor(im, filtered);
    for y=1:h
        for x=1:w
            if(temp(y,x))
              colorIm(y,x,:) = [0.1, 0.1, 0.9];
            end
        end
    end
    % staffs area
    for y=[Corners(i, 1), Corners(i, 3)]
        for x=1:w
            colorIm(y,x,:) = [0.1, 0.9, 0.9];
        end
    end
    for y=Corners(i, 1):Corners(i, 3)
        for x=[1,w]
            colorIm(y,x,:) = [0.1, 0.9, 0.9];
        end
    end
    % symbols
    for j=1:length(Symbols)
        temp = Symbols(j).Image;
        beginX = int16(Symbols(j).BoundingBox(1));
        beginY = int16(Symbols(j).BoundingBox(2))+Corners(i,1)-1;
        [hSym, wSym] = size(temp);
        for y=beginY:beginY+hSym-1
            for x=beginX:beginX+wSym-1
                if(temp(y-beginY+1,x-beginX+1))
                    if(Notes(j).Id == -1)
                        colorIm(y,x,:) = [0.9, 0.9, 0.1];
                    elseif((Notes(j).Id > 0)&&(~consolidateTab(j,1)))
                        colorIm(y,x,:) = [0.1, 0.9, 0.1];
                    elseif((Notes(j).Id > 0)&&(consolidateTab(j,1)))
                        colorIm(y,x,:) = [0.1, 0.5, 0.1];
                    else
                        colorIm(y,x,:) = [0.9, 0.1, 0.1];
                    end  
                end
            end
        end
    end
    %---------------------------------------------------
    
    
    %---------------------------------------------------
    % Consolidating and clearing unnecessary notes/symbols
    %---------------------------------------------------
    % remove trashy shapes
    indexes = find([Notes.Id] > 0);
    Notes = Notes([Notes.Id] > 0);
    consolidateTab = consolidateTab(indexes);
    
    % remove extra copies
    maxIdx = max(consolidateTab);
    for j=1:maxIdx
        groupB = find(consolidateTab == j,1, 'first');
        groupE = find(consolidateTab == j,1, 'last');
        Notes = [Notes(1:groupB), Notes(groupE+1:end)];
        consolidateTab = [consolidateTab(1:groupB); consolidateTab(groupE+1:end)];
    end
    
    NotesDB = [NotesDB, Notes];

end % end of main for loop
%---------------------------------------------------
%---TEST----
[sharp,flat]=findScale(NotesDB)
%---TEST END----

%-------------------------------------------------------------------
% Classification and separation of identified clefs and notes
% Convertion to *.XML file
%-------------------------------------------------------------------
[~, NumRows] = size(NotesDB);
Matrix2XML(NotesDB, NumRows, i, 0, 0);
%-------------------------------------------------------------------



figure;
imshow(colorIm);
title("Coloured");

% figure;
% SepSymCor = ConnectSeperatedSymbols(Symbols, [2,3,4]); % reczne grupowanie
% SepSym = CutOutImage(CutOut, SepSymCor);
% imshow(SepSym);
% title("group test");
% group = Classify(SepSym, db, dbLen);

figure;
subplot(2,1,1);
% SepSymCor = ConnectSeperatedSymbols(Symbols, [6, 7]);
% SepSym = CutOutImage(CutOut, SepSymCor);
% imshow(imresize(Symbols(14).Image, [128, 64]));
% subplot(2,1,2);
% imshow(imrotate(getRecord(db, 15).Image, 180));
% figure;
% sum(bitxor(imresize(Symbols(23).Image, [128, 64]), imrotate(getRecord(db, 15).Image, 180)), 'all')
% sum(bitxor(imresize(Symbols(23).Image, [128, 64]), getRecord(db, 27).Image), 'all')
figure;
for s=1:length(Symbols)
   subplot(6,6,s);
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


