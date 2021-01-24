function measuremax = CheckMeasures(Database, sizeofDatabase)
%recounting measures

    measuremax = 1;
    lastmeasure = 1;
    
    for i = 1:sizeofDatabase 
        if mod(getRecord(Database,i).Staff,2) == 1
            if lastmeasure ~= getRecord(Database,i).Measure
                measuremax = measuremax + 1;
            end    
        end    
    end    

end

