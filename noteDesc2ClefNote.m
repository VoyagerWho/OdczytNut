function [NoteDatabase, sizeDb, ClefDatabase, maxmeasure] = noteDesc2ClefNote(Database, sizeOfDatabase, transpose)
%func which sorts clefs, sharps/flats and notes 2 separate matrices

    ClefDatabase = [];
    NoteDb = [];
    NoteDatabase = [];
    alter = 0;
    maxmeasure = CheckMeasures(Database, sizeOfDatabase);

    for i = 1:sizeOfDatabase
        if getRecord(Database,i).Id == 13
            ClefDatabase = addRecord(ClefDatabase, struct('Name', 'G', 'Height', 2)); 
        elseif getRecord(Database,i).Id == 14
            ClefDatabase = addRecord(ClefDatabase, struct('Name', 'F', 'Height', 4));
%         elseif getRecord(Database,i).Id == 15
%             beats = 4;
%             beattype = 4;
        elseif getRecord(Database, i).Id == 11
            alter = 1;
        elseif getRecord(Database, i).Id == 12
            alter = -1;
        elseif getRecord(Database, i).Id == 10
            alter = 0;
        else 
            [step, octave, alter] = Height2Step(getRecord(Database,i).Height, getRecord(Database,i).Staff, transpose, alter);  
            staff = mod(getRecord(Database,i).Staff, 2);
            if staff == 0
                staff = 2;
            end
                         
            
%%%%%%%%%%%%
%LICZENIE TAKTÓW 
%%%%%%%%%%%%%
            
            
            NoteDb = addRecord(NoteDb, struct('Id', getRecord(Database,i).Id, 'Name', getRecord(Database,i).Name, 'Step', step, 'Octave', octave, 'Alter', alter, 'Rotated', getRecord(Database,i).Rotated, 'Measure', getRecord(Database,i).Measure, 'Staff', staff));
            alter = 0;
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