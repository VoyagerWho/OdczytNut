function [Classified, differences]= Classify(im, db, dbLen, factor)
%CLASSIFY Classify what note is on image
%   Classificator whether image shows one of known symbols 
    Classified = noteDesc(0, 'nil', 0, 0, 0, 0);
    testObj = imresize(im, [128 64]);
    differences = zeros(dbLen, 1);
    minDiff = 128*64;
    threshold = 1000*factor; % arbitrary for now
    for i=1:dbLen
        dbRec = getRecord(db, i);
        diff = sum(bitxor(testObj, dbRec.Image), 'all');
        differences(i) = diff;
        
        if(diff < threshold) && (diff < minDiff)
            Classified = noteDesc(dbRec.Id, dbRec.Name, 0, 0, 0, 0);
            minDiff=diff;
        elseif(dbRec.Rotable)
            diff = sum(bitxor(testObj, imrotate(dbRec.Image, 180)), 'all');
            if(diff < threshold) && (diff < minDiff)
                Classified = noteDesc(dbRec.Id, dbRec.Name, 1, 0, 0, 0);
                minDiff=diff;
                differences(i) = diff;
            end
        end
    end
end

