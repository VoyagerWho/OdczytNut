function [fifths, ton, ton2] = tonation(signature, numberofSig, transpose)

% % simple tonation 2 fifths translator
%     
%     if signature == "flat"   
%        fifths = 0-numberofSig;
%     elseif signature == "sharp"
%        fifths = numberofSig;
%     else
%        fifths = 0;
%     end
%     

%tonation 2 fifths translator + tonation
%circle of fifths - changing the tonation after transpose
 
    ton =0;
    
    if signature == "sharp"
       switch numberofSig
           case 1
               ton = 7;
           case 2
               ton = 2;
           case 3
               ton = 9;
           case 4
               ton = 4;
           case 5
               ton = 11;
           case 6
               ton = 6;
           case 7
               ton = 1;
       end        
    elseif signature == "flat"
        switch numberofSig
           case 1
               ton = 5;
           case 2
               ton = 10;
           case 3
               ton = 3;
           case 4
               ton = 8;
           case 5
               ton = 1;
           case 6
               ton = 6;
           case 7
               ton = 11;
       end
    end 
    
    ton2 = mod(ton + transpose, 12);
    
    switch ton2        
        case 0
            fifths = 0;
        case 1
            fifths = -5;   
        case 2
            fifths = 2;
        case 3
            fifths = -3;
        case 4
            fifths = 4;
        case 5
            fifths = -1;
        case 6
            fifths = 6;
        case 7
            fifths = 1;
        case 8
            fifths = -4;
        case 9
            fifths = 3;
        case 10
            fifths = -2;
        case 11
            fifths = 5;
            
    end   
end

    
    