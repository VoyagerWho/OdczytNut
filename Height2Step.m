function [step, octave] = Height2Step(Height, Clef)
%function determining step and octave for a note from its height
    if Clef == 'G'
        switch Height
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
        end 
    elseif Clef == 'F'
        switch Height
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
        end 
    end    
end