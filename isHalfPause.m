function  flag = isHalfPause(posLines3, posLines4, symBBox)
%ISHALFPAUSE Checks if pause is whole or half
           
            diffUp=abs(symBBox(2)-posLines4);
            diffDown=abs(symBBox(2)+symBBox(4)-posLines3);
            
            if  diffDown< diffUp
                 flag = true;
            else
                flag = false;
            end
end

