function [NoteDatabase, sizeDb, ClefDatabase, maxmeasure] = noteDesc2ClefNote(Database, sizeOfDatabase, transpose, numberofSig, ton, ton2)
%func which sorts clefs, sharps/flats and notes 2 separate matrices and
%renumerate the measures and staffs

    ClefDatabase = [];
    NoteDb = [];
    NoteDatabase = [];
    maxmeasure = 1;
    alter = 2;
    accidental = 0;
    laststaff = 1;
    lastmeasure = 1;
    measure = 1;

    for i = 1:sizeOfDatabase
        if getRecord(Database,i).Id == 13
            ClefDatabase = addRecord(ClefDatabase, struct('Name', 'G', 'Height', 2));
            for j = 1:numberofSig
                i = i+1;
            end    
        elseif getRecord(Database,i).Id == 14
            ClefDatabase = addRecord(ClefDatabase, struct('Name', 'F', 'Height', 4));
            for j = 1:numberofSig
                i = i+1;
            end 
        elseif getRecord(Database,i).Id == 15
%             beats = 4;
%             beattype = 4;          
        elseif getRecord(Database, i).Id == 11
             accidental = 1;
        elseif getRecord(Database, i).Id == 12
             accidental = -1;
        elseif getRecord(Database, i).Id == 10
             accidental = 0; 
        else 
            if getRecord(Database, i).Id <= 5
                [step, octave, alter] = Height2Step(getRecord(Database,i).Height, getRecord(Database,i).Staff, transpose, accidental, ton, ton2);  
            else
                step = getRecord(Database, i).Height;
                octave = -1;               
            end
            if mod(getRecord(Database,i).Staff, 2) == 0
                staff = 2;
                if getRecord(Database,i).Staff == 2
                   measure = getRecord(Database,i).Measure;
                else
                   measure = lastmeasure + getRecord(Database,i).Measure;
                end                    
            else
                staff = 1;
                if getRecord(Database,i).Staff == 1
                   lastmeasure = getRecord(Database,i).Measure;
                   measure = lastmeasure;
                else
                   if laststaff ~= getRecord(Database,i).Staff
                        lastmeasure = measure;                        
                   end
                   measure = lastmeasure + getRecord(Database,i).Measure;
                   laststaff = getRecord(Database,i).Staff;
                end
            end            
            
            NoteDb = addRecord(NoteDb, struct('Id', getRecord(Database,i).Id, 'Name', getRecord(Database,i).Name, 'Step', step, 'Octave', octave, 'Alter', alter, 'Rotated', getRecord(Database,i).Rotated, 'Measure', measure, 'Staff', staff));
            accidental = 0;
            alter = 2;
            if measure>maxmeasure
                maxmeasure = measure;
            end    
        end    
    end
    
    %SORTING NOTES BY MEASURES%
    [sizeDb,~] = size(NoteDb);     
    for i = 1:maxmeasure
        for j = 1:sizeDb
            if getRecord(NoteDb,j).Measure == i
                NoteDatabase = addRecord(NoteDatabase, getRecord(NoteDb,j));
            end    
        end    
    end
    [sizeDb,~] = size(NoteDatabase); 
end