function [sharp,flat] = findScale(NotesDB)
%FINDSCALE
% Returns the number of sharps and flats in the beginning
% Helps in determining the scale
sharp=0;
flat=0;

for i=1:length(NotesDB)
    switch NotesDB(i).Id
        case 11
            sharp=sharp+1;
        case 12
            flat=flat+1;
        case 15
            flat=0;
            sharp=0;
            break;
        case {13 14}
            continue;   
        otherwise
            break;
    end
end

