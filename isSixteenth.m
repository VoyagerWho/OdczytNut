function [six, index] = isSixteenth(db,testObj, diff)
%Easy-way to distinguish sixteenth
for i = 32:45
    if sum(bitxor(testObj, getRecord(db, i).Image), 'all')<diff
        six = true;
        index = i;
        break;
    else
        six = false;
        index = 0;
    end
end

