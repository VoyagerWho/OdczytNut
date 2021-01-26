function height = CalculateHeight(posLines, note, symBBox)
%CALCULATEHEIGHT calculate position of note on staff from boundingbox
% output notes:
% C = -2
% D = -1
% E = 0
% F = 1
% G = 2
% A = 3
% H = 4
% etc
% output whole pause: 1
% output half pause: -1

    middle = symBBox(4)/2;
    jump = (posLines(5)-posLines(4))/2;
    height = note.Height;
    switch note.Id
        case 1
            posMiddle  = symBBox(2)+middle; 
            height = round((posLines(5)-posMiddle)/jump);
        case {2 3}
             if note.Height == 0
                if note.Rotated == 0
                    position = symBBox(2)+(symBBox(4)*7)/8;
                else
                    position = symBBox(2)+(symBBox(4))/8;
                end
                height = round((posLines(5)-position)/jump);
            else
                if note.Rotated == 1
                    height= 8 - note.Height ;  
                end
            end
        case {4 5}
            if note.Height == 0
                if note.Rotated == 0
                    position = symBBox(2)+(symBBox(4)*17)/20;
                else
                    position = symBBox(2)+(symBBox(4)*3)/20;
                end
                height = round((posLines(5)-position)/jump);
            end
            
        case 6
            if isHalfPause(posLines(3),posLines(2), symBBox)
                height = -1;
            else
                height = 1;
            end

        otherwise
            height = 0;
    end
end

