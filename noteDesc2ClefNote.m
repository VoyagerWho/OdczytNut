function [NoteDatabase, size, ClefDatabase, beats, beattype] = noteDesc2ClefNote(Database, sizeOfDatabase)
%func which sorts clefs, sharps/flats and notes 2 separate matrices

    ClefDatabase = [];
    NoteDatabase = [];
    size = 0;

    for i = 1:sizeOfDatabase
        if getRecord(Database,i).Id == 13
            ClefDatabase = addRecord(ClefDatabase, struct('Name', 'G', 'Height', 2)); 
        elseif getRecord(Database,i).Id == 14
            ClefDatabase = addRecord(ClefDatabase, struct('Name', 'F', 'Height', 4));
        elseif getRecord(Database,i).Id == 15
            beats = 4;
            beattype = 4;
        else
            if getRecord(Database, i-1).Id == 11
                alter = 1;
            elseif getRecord(Database, i-1).Id == 12
                alter = -1;
            else
                alter = 0;
            end 
            [step, octave] = Height2Step(getRecord(Database,i).Height, getRecord(Database,i).Clef);  
            NoteDatabase = addRecord(NoteDatabase, struct('Id', getRecord(Database,i).Id, 'Name', getRecord(Database,i).Name, 'Step', step, 'Octave', octave, 'Alter', alter, 'Rotated', getRecord(Database,i).Rotated));
            size = size + 1;
        end    
    end

end