function [step, octave, alter] = Height2Step(Height, Staff, transpose, alter, ton)
%function determining step and octave for a note from its height
%function that transpose notes by x semi-steps

%     if alter == -1
%         height = Height + (transpose-1)/2;
%     elseif alter == 1
%         height = Height + (transpose+1)/2;
%     else
%         height = Height + transpose/2;
%     end    
%     
%     if mod(height,1) ~= 0
%         if transpose>=0
%             height = height - 0.5;
%             alter = 1;
%         elseif transpose<0
%             height = height + 0.5;
%             alter = -1;
%         end    
%     else
%         alter = 0;
%     end    
height = Height;
alter = 2;

    if mod(Staff,2) == 1
        switch height
            case -5
                step = 'G';
                octave = 3;
            case -4
                step = 'A';
                octave = 3;
            case -3
                step = 'B';
                octave = 3;
            case -2
                step = 'C';
                octave = 4;
            case -1
                step = 'D';
                octave = 4;    
            case 0
                step = 'E';
                octave = 4;
            case 1
                step = 'F';
                octave = 4;
            case 2
                step = 'G';
                octave = 4;
            case 3
                step = 'A';
                octave = 4;
            case 4
                step = 'B';
                octave = 4;
            case 5
                step = 'C';
                octave = 5;
            case 6
                step = 'D';
                octave = 5;
            case 7
                step = 'E';
                octave = 5;
            case 8
                step = 'F';
                octave = 5;
            case 9
                step = 'G';
                octave = 5;
            case 10
                step = 'A';
                octave = 5;
            case 11
                step = 'B';
                octave = 5;
            case 12
                step = 'C';
                octave = 6;
            case 13
                step = 'D';
                octave = 6;    
        end 
        
    elseif mod(Staff,2) == 0
        switch height
            case -5
                step = 'B';
                octave = 1;
            case -4
                step = 'C';
                octave = 2;
            case -3
                step = 'D';
                octave = 2;
            case -2
                step = 'E';
                octave = 2;
            case -1
                step = 'F';
                octave = 2;    
            case 0
                step = 'G';
                octave = 2;
            case 1
                step = 'A';
                octave = 2;
            case 2
                step = 'B';
                octave = 2;
            case 3
                step = 'C';
                octave = 3;
            case 4
                step = 'D';
                octave = 3;
            case 5
                step = 'E';
                octave = 3;
            case 6
                step = 'F';
                octave = 3;
            case 7
                step = 'G';
                octave = 3;
            case 8
                step = 'A';
                octave = 3;
            case 9
                step = 'B';
                octave = 3;
            case 10
                step = 'C';
                octave = 4;
            case 11
                step = 'D';
                octave = 4;
            case 12
                step = 'E';
                octave = 4;
            case 13
                step = 'F';
                octave = 4;    
        end 
    end
    
    % recalculating alters for different tonations - circle of fifths
    disp('TON TON TON');
    disp(ton);
    switch ton
        case 1
            switch step
                case {'B', 'E', 'A', 'D', 'G'}  
                    if alter == 1
                       alter = 0;
                    else
                       alter = -1;
                    end
            end
        case 2
            switch step
                case {'F', 'C'}
                    if alter == -1
                       alter = 0;
                    else
                       alter = 1;
                    end 
            end  
        case 3
            switch step
                case {'B', 'E', 'A'}
                    if alter == 1
                        alter = 0;
                    else
                        alter = -1;
                    end                
            end  
        case 4
            switch step
                case {'F', 'C', 'G', 'D'}
                    if alter == -1
                        alter = 0;
                    else
                        alter = 1;
                    end                
            end
        case 5
            switch step
                case {'B'}
                    if alter == 11
                        alter = 0;
                    else
                        alter = -1;
                    end                
            end
        case 6
            switch step
                case {'B', 'E', 'A', 'D', 'G', 'C'}
                    if alter == 1
                        alter = 0;
                    else
                        alter = -1;
                    end                
            end
        case 7
            switch step
                case {'F'}
                    if alter == -1
                        alter = 0;
                    else
                        alter = 1;
                    end               
            end
        case 8
            switch step
                case {'B', 'E', 'A', 'D'}
                    if alter == 1
                        alter = 0;
                    else
                        alter = -1;
                    end               
            end
        case 9
            switch step
                case {'F', 'C', 'G'}
                    if alter == -1
                        alter = 0;
                    else
                        alter = 1;  
                    end                
            end
        case 10
            switch step
                case {'B', 'E'}
                    if alter == 1
                        alter = 0;
                    else
                        alter = -1;
                    end                
            end
        case 11
            switch step
                case {'F', 'C', 'G', 'D', 'A'}
                    if alter == -1
                        alter = 0;
                    else
                        alter = 1;
                    end                
            end
    end        
    
end