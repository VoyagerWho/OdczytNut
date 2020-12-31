function height = CalculateHeight(posLines, note, symBBox)
%CALCULATEHEIGHT calculate position of note on staff from boundingbox
%   not much to add
    middle = symBBox(4)/2;
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

