function colorClassifier(im, filtered,  Symbols, Notes)
%COLORCLASSIFIER Classifies and show notes in colors

%staff - pięciolinia-------------------------------------
staff = bitxor(im, filtered); 
staffColored = binaryImageToRGB(staff, 0.1, 0.1, 0.9); 

%nieklasyfikowane -------------------------------------
% unclassified=[];
% for i=1:length(Symbols)
    
%    if (Notes(1).Id == 0)
%         unclassified = Symbols(1);
%    end
% end
figure;
title("Let's classify!");
% subplot(1,2,1);
imshow(staffColored);
% unclassified

% staffColored(Symbols(i).BoundingBox(2):Symbols(i).BoundingBox(2)+Symbols(i).BoundingBox(4),Symbols(i).BoundingBox(1):Symbols(i).BoundingBox(1)+Symbols(i).BoundingBox(3), :) = Symbols(i).Image*colour;


%Lila na później - 0.8, 0.8, 1


end

