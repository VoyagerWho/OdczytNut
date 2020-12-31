function height = CalculateHeightGroup(posLines, note, SepSymCor)
%CALCULATEHEIGHTGROUP calculate position of note on staff from corners of
%group
%   not much to add
    middle = (SepSymCor(3)-SepSymCor(1))/2;
    jump = (posLines(2)-posLines(1))/2;
    switch note.Id
        case 1
            statements
        case 2
            statements
        ...
        otherwise
            height = 0;
    end
end

