function [coloredIm] = Transpose(filePath,resultPath,metrum, signature, numberofSig, transpos)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    im = double(rgb2gray(imread(filePath)))/255;
    coloredIm = cat(3, im, im, im);
    im = ~imbinarize(im); 
    [h,w]=size(im);
    
    %---------------------------------------------------
    % Finding lines of staffs
    %---------------------------------------------------
    horBrightness = sum(double(im), 2);
    horBrightThreshold = max(horBrightness)*0.8;
    posLines=find(horBrightness>horBrightThreshold);
    filtered = ClearWithFilterUD(im, posLines', [0;1;0]);
    %---------------------------------------------------


    %---------------------------------------------------
    % Designating corners of staffs' image area
    %---------------------------------------------------
    dist = round((posLines(6) - posLines(5))/2.0);
    numberOfLines = length(posLines);
    numberOfStaves = numberOfLines/5;
    Corners = zeros(numberOfStaves, 4);
    for i=1:numberOfStaves
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
    for i=1:numberOfStaves

        CutOut = CutOutImage(filtered, Corners(i,:));
        Symbols = regionprops(CutOut, 'Area','BoundingBox', 'Image');

        %---------------------------------------------------
        % Second method of sepereting measures
        % Uses ratio between w and h of Symbols' BBox
        %---------------------------------------------------
        linearRatio = 0.15;
        for j=1:length(Symbols)
            Symbols(j).Linear = Symbols(j).BoundingBox(3)/Symbols(j).BoundingBox(4);
        end
        %---------------------------------------------------



        %---------------------------------------------------
        % First classification designed for single symbols
        % Clears of small artifacts
        %---------------------------------------------------
        Notes=repmat(noteDesc(0, 'nil', 0, 0, 0, 0), 1, 1 );

        for j=1:length(Symbols)
            if(Symbols(j).Area > 10)
                if(Symbols(j).Linear < linearRatio)
                    Notes(j)= noteDesc(-1, 'measure', 0, 0, 0, 0);
                else
                    Notes(j)= Classify(Symbols(j).Image, db, dbLen);
                end
            else
                Notes(j)= noteDesc(0, 'nil', 0, 0, 0, 0);
            end
        end
        %---------------------------------------------------


        %---------------------------------------------------
        % Second classification designed for seperated symbols
        % Connects neighbours to find notes
        %---------------------------------------------------
        consolidateIndex=1;
        consolidateTab=zeros(length(Symbols), 1);
        measureNumber=0;
        for j=1:length(Symbols)-1
            if(Notes(j).Id == 0)
                for k=min(j+1, length(Symbols)):min(j+3, length(Symbols))
                    if(Notes(k).Id == 0)
                        SepSymCor = ConnectSeperatedSymbols(Symbols, j:k);
                        SepSym = CutOutImage(CutOut, SepSymCor);
                        Notes(j) = Classify(SepSym, db, dbLen);

                        if(Notes(j).Id ~= 0)
                            BBox = cornersToBBox(SepSymCor);
                            Notes(j).Height = CalculateHeight((posLines((5*(i-1)+1):5*i)-Corners(i, 1)), Notes(j), BBox);
                            Notes(j).Staff = i;
                            Notes(j).Measure = measureNumber;
                            consolidateTab(j:k) = consolidateIndex;
                            consolidateIndex=consolidateIndex+1;
                            Notes(j+1:k) = Notes(j);
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
                  coloredIm(y,x,:) = [0.1, 0.1, 0.9];
                end
            end
        end
        % staffs area
        for y=[Corners(i, 1), Corners(i, 3)]
            for x=1:w
                coloredIm(y,x,:) = [0.1, 0.9, 0.9];
            end
        end
        for y=Corners(i, 1):Corners(i, 3)
            for x=[1,w]
                coloredIm(y,x,:) = [0.1, 0.9, 0.9];
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
                            coloredIm(y,x,:) = [0.9, 0.9, 0.1];
                        elseif((Notes(j).Id > 0)&&(~consolidateTab(j,1)))
                            coloredIm(y,x,:) = [0.1, 0.9, 0.1];
                        elseif((Notes(j).Id > 0)&&(consolidateTab(j,1)))
                            coloredIm(y,x,:) = [0.1, 0.5, 0.1];
                        else
                            coloredIm(y,x,:) = [0.9, 0.1, 0.1];
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

    %-------------------------------------------------------------------
    % Classification and separation of identified clefs and notes
    % Convertion to *.XML file
    %-------------------------------------------------------------------
    [~, NumRows] = size(NotesDB);
    [fifths, ton, ton2] = tonation(signature, numberofSig, transpos);
    Matrix2XML(NotesDB, NumRows, fifths, ton, ton2, transpos, metrum(1,1), metrum(1,2), resultPath);    %-------------------------------------------------------------------
    %-------------------------------------------------------------------
end

