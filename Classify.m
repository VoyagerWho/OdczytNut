function Classified= Classify(im, db, dbLen)
%CLASSIFY Classify what note is on image
%   Classificator whether image shows one of known symbols 
    Classified = noteDesc(0, 'nil', 0, 0, 0, 0);
    testObj = imresize(im, [128 64]);
    minDiff = 128*64;
    threshold = 1000;
    for i=1:dbLen
        dbRec = getRecord(db, i);
        diff = sum(bitxor(testObj, dbRec.Image), 'all');
        
        if(diff < threshold) && (diff < minDiff)
%             Classified = noteDesc(dbRec.Id, dbRec.Name, 0, 0, 0, 0);
            Classified = noteDesc(dbRec.Id, dbRec.Name, 0, dbRec.Height, 0, 0);
            minDiff=diff;
        elseif(dbRec.Rotable)
            diff = sum(bitxor(testObj, imrotate(dbRec.Image, 180)), 'all');
            if(diff < threshold) && (diff < minDiff)
%                 Classified = noteDesc(dbRec.Id, dbRec.Name, 1, 0, 0, 0);
                Classified = noteDesc(dbRec.Id, dbRec.Name, 1, dbRec.Height, 0, 0);
                minDiff=diff;
            end
        end
    end
end

