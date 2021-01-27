function [step, alter, octave] = transposition(accidental,step,transpos,octave,ton_first)
%transposition of steps from given transpos

    switch ton_first
        case 1
            switch step
                case {'B', 'E', 'A', 'D', 'G'}  
                    accidental = -1;
            end
        case 2
            switch step
                case {'F', 'C'}
                    accidental = 1;
            end  
        case 3
            switch step
                case {'B', 'E', 'A'}
                    accidental = -1;        
            end  
        case 4
            switch step
                case {'F', 'C', 'G', 'D'}
                     accidental = 1;             
            end
        case 5
            switch step
                case {'B'}
                    accidental = -1;
            end
        case 6
            switch step
                case {'B', 'E', 'A', 'D', 'G', 'C'}
                    accidental = -1;                
            end
        case 7
            switch step
                case {'F'}
                    accidental = 1;              
            end
        case 8
            switch step
                case {'B', 'E', 'A', 'D'}
                    accidental = -1;              
            end
        case 9
            switch step
                case {'F', 'C', 'G'}
                    accidental = 1;               
            end
        case 10
            switch step
                case {'B', 'E'}
                    accidental = -1;               
            end
        case 11
            switch step
                case {'F', 'C', 'G', 'D', 'A'}
                    accidental = 1;              
            end
    end   

    value = 0;

    switch step
        case 'C'
            value = accidental + transpos;
        case 'D'
            value = 2 + accidental + transpos;
        case 'E'
            value = 4 + accidental + transpos;
        case 'F'
            value = 5 + accidental + transpos;
        case 'G'
            value = 7 + accidental + transpos;
        case 'A'
            value = 9 + accidental + transpos;
        case 'B'
            value = 11 + accidental + transpos;
    end   
    
    if value >= 12
        octave = octave+1;
    elseif  value < 0 
        octave = octave-1;
    end
    
    switch mod(value,12)
        case 0
            step = 'C';
            alter = 0;
        case 1
            step = 'D';
            alter = -1;
        case 2
            step = 'D';
            alter = 0;
        case 3
            step = 'E';
            alter = -1;
        case 4
            step = 'E';
            alter = 0;
        case 5
            step = 'F';
            alter = 0;
        case 6
            step = 'G';
            alter = -1;
        case 7
            step = 'G';
            alter = 0;
        case 8
            step = 'A';
            alter = -1;
        case 9
            step = 'A';
            alter = 0;
        case 10
            step = 'B';
            alter = -1;
        case 11
            step = 'B';
            alter = 0;
    end      
       
end

