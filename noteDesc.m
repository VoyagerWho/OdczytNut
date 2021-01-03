function desc = noteDesc(id, name, rotated, height, clef)
%NOTEDESC Description of a note
%   Creates struct containing description of a note
    desc = struct('Id', id, 'Name', name, 'Rotated', rotated, 'Height', height, 'Clef', clef); 
end
