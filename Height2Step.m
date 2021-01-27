function [step, octave, alter] = Height2Step(Height, Staff, transpose, accidental, ton, ton2)
%function determining step and octave for a note from its height
%function that transpose notes by x semi-steps

alter = 2;%%default value - alter should be -1, 1 or 0; 

    if mod(Staff,2) == 1
        switch Height
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
        switch Height
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
    
    if transpose ~= 0
       [step, alter, octave] = transposition(accidental,step,transpose,octave,ton);
    end    
    
    % recalculating alters for different tonations - circle of fifths
    switch ton2
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
                    if alter == 1
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