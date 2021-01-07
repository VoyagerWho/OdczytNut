function [quarter, index] = isQuarter(db,testObj, diff, rotation)
%Easy-way to distinguish quarter
for i = 11:17
    if rotation==0 && sum(bitxor(testObj, getRecord(db, i).Image), 'all')<diff
        quarter = true;
        index = i;
        break;
    elseif rotation == 1 && sum(bitxor(testObj, imrotate(getRecord(db, i).Image,180)), 'all')<diff
        quarter = true;
        index = i;
        break;
    else
        quarter = false;
        index = 0;
    end
end

