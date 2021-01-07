function [Classified]= Classify(im, db, dbLen)
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
        if(diff < 1000) % arbitrary for now
            if dbRec.Id==2
               [quarter, index] = isQuarter(db,testObj,diff,0);
                if quarter
                   dbRec = getRecord(db, index); 
                end    
            end
            if dbRec.Id==3
                [eighth, index] = isEighth(db,testObj,diff);
                if eighth
                    dbRec = getRecord(db,index);
                end
            end    
            if dbRec.Id==4
                [six, index] = isSixteenth(db,testObj,diff);
                if six
                    dbRec = getRecord(db,index);
                end    
            end    
            Classified = noteDesc(dbRec.Id, dbRec.Name, 0, 0, 0, 0);
            minDiff=diff;
        elseif(dbRec.Rotable)
            diff = sum(bitxor(testObj, imrotate(dbRec.Image, 180)), 'all');
            if(diff < 1000) % arbitrary for now
                if dbRec.Id==2
                    [quarter, index] = isQuarter(db,testObj,diff,1);
                    if quarter
                        dbRec = getRecord(db, index);
                    end    
                end 
                Classified = noteDesc(dbRec.Id, dbRec.Name, 1, 0, 0, 0);
                minDiff=diff;
                differences(i) = diff;
            end
        end
    end
end

