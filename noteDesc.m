function desc = noteDesc(id, name, rotated, height, staff, measure)
%NOTEDESC Description of a note
%   Creates struct containing description of a note
% numer pięciolinii, numer taktu
    desc = struct('Id', id, 'Name', name, 'Rotated', rotated, 'Height', height, 'Staff', staff, 'Measure', measure); 
end
