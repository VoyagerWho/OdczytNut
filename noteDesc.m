function desc = noteDesc(id, name, rotated, height)
%NOTEDESC Description of a note
%   Creates struct containing description of a note
    desc = struct('Id', id, 'Name', name, 'Rotated', rotated, 'Height', height); 
end

