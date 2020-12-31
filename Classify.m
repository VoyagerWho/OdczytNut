function Classified = Classify(im, db, dbLen)
%CLASSIFY Classify what note is on image
%   Classificator whether image shows one of known symbols 
    Classified = noteDesc(0, 'nil', 0, 0);
    testObj = imresize(im, [128 128]);
    for i=1:dbLen
        dbRec = getRecord(db, i);
        diff = sum(bitxor(testObj, dbRec.Image), 'all');
        if(diff < 1600) % arbitrary for now
            Classified = noteDesc(dbRec.Id, dbRec.Name, 0, 0);
            break;
        elseif(dbRec.Rotable)
            diff = sum(bitxor(testObj, imrotate(dbRec.Image, 180)), 'all');
            if(diff < 1600) % arbitrary for now
                Classified = noteDesc(dbRec.Id, dbRec.Name, 1, 0);
                break;
            end
        end
    end
end

