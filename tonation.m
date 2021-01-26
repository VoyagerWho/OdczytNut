function fifths = tonation(signature,numberofSig)
%tonation 2 fifths translator
    
    if signature == "flat"   
       fifths = 0-numberofSig;
    elseif signature == "sharp"
       fifths = numberofSig;
    else
       fifths = 0;
    end 
    
%  if signature == "flat"
%        switch numberofSig
%            case 0
%                ton = 0; %%koło kwintowe
%            case 1
%                ton = 7;
%            case 2
%                ton = 2;
%            case 3
%                ton = 9;
%            case 4
%                ton = 4;
%            case 5
%                ton = 11;
%            case 6
%                ton = 6;
%            case 7
%                ton = 1;
%        end        
%     elseif signature == "sharp"
%         switch numberofSig
%            case 0
%                ton = 0;
%            case 1
%                ton = 5;
%            case 2
%                ton = 10;
%            case 3
%                ton = 3;
%            case 4
%                ton = 8;
%            case 5
%                ton = 1;
%            case 6
%                ton = 6;
%            case 7
%                ton = 11;
%        end
%     end 
%     
%     ton = mod(ton + transpose, 12);
%     
%     switch ton        
%         case 0
%             fifths = 0;
%         case 1
%             if signature == "flat"
%                 fifths = 0;
%             else
%                 fifths = 
%             end    
%         case 2
%             fifths = 0;
%         case 3
%             fifths = 0;
%         case 4
%             fifths = 0;
%         case 5
%             fifths = 0;
%         case 6
%             fifths = 0;
%         case 7
%             fifths = 0;
%         case 8
%             fifths = 0;
%         case 9
%             fifths = 0;
%         case 10
%             fifths = 0;
%         case 11
%             fifths = 0;
%             
%     end
%     
%     
% end

    
    
end

