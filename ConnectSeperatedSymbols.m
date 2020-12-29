function SymbolCorners = ConnectSeperatedSymbols(Symbols, Indexes)
%UNTITLED4 connect seperated symbols
%   Connects neigbour unrecognised symbols to find damaged symbols
    numberOfParts = length(Indexes);
    Corners = zeros(numberOfParts, 4);
    for i=1:numberOfParts
        Corners(i, 2)=Symbols(Indexes(i)).BoundingBox(1);
        Corners(i, 1)=Symbols(Indexes(i)).BoundingBox(2);
        Corners(i, 4)=Symbols(Indexes(i)).BoundingBox(3) + Symbols(Indexes(i)).BoundingBox(1)-1;
        Corners(i, 3)=Symbols(Indexes(i)).BoundingBox(4) + Symbols(Indexes(i)).BoundingBox(2)-1;
    end
    SymbolCorners = [min(Corners(:,1)), min(Corners(:,2)), max(Corners(:,3)), max(Corners(:,4))];
end

