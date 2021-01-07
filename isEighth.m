function [eighth, index] = isEighth(db,testObj, diff)
%Easy-way to distinguish eighth
for i = 18:31
    if sum(bitxor(testObj, getRecord(db, i).Image), 'all')<diff
        eighth = true;
        index = i;
        break;
    else
        eighth = false;
        index = 0;
    end
end

