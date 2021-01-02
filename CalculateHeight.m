function height = CalculateHeight(p1,p2,p3,p4,p5, note, symBBox, GkeyFlag)
%CALCULATEHEIGHT calculate position of note on staff from boundingbox
% output notes:
% C = -2
% D = -1
% E = 0
% F = 1
% G = 2
% A = 3
% H = 4
% output whole pause: 1
% output half pause: -1

    middle = symBBox(4)/2;
    jump = (p1-p2)/2;
    
    switch note.Id
        case 1
            posMiddle  = symBBox(2)+middle; 
            height = round((p1-posMiddle)/jump);
            if ~GkeyFlag
                height = height - 5;
            end
            
        case {2 3 4 5}
            if note.Rotated == 0
                position = symBBox(2)+(symBBox(4)*17)/20;
            else
                position = symBBox(2)+(symBBox(4)*3)/20;
            end
            height = round((p1-position)/jump);
            
            if ~GkeyFlag
                height = height - 5;
            end
       
        case 6
            if isHalfPause(p3,p4,note,symBBox)
                height = -1;
            else
                height = 1;
            end

        otherwise
            height = 0;
    end
end

