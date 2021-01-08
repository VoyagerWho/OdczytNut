function [step, octave, alter] = Height2Step(Height, Staff, transpose, alter)
%function determining step and octave for a note from its height
%function that transpose notes by x semi-steps
    
    if alter == -1
        height = Height + transpose/2 -1;
    elseif alter == 1
        height = Height + transpose/2 +1;
    else
        height = Height + transpose/2;
    end    
    
    if mod(height,1) ~= 0
        if transpose>0
            height = height - 0.5;
            alter = 1;
        elseif transpose<0
            height = height + 0.5;
            alter = -1;
        end    
    else
        alter = 0;
    end    

    if mod(Staff,2) == 1
        switch height
            case -5
                step = 'G';
                octave = 3;
            case -4
                step = 'A';
                octave = 3;
            case -3
                step = 'H';
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
                step = 'H';
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
                step = 'H';
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
                step = 'H';
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
                step = 'H';
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
                step = 'H';
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
end