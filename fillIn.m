function fillIn(time,beattype,output)
%Deafault pause in case of wrongly recognized note

    switch time*beattype
            case 16
                disp('whole puase');
                fprintf(output,'<note>\n<rest measure="yes"/>\n<duration>4</duration>\n');
            case 8
                disp('half puase');
                fprintf(output,'<note>\n<rest measure="yes"/>\n<duration>2</duration>\n');
            case 4
                disp('quarter puase');
                fprintf(output,'<note>\n<rest measure="yes"/>\n<duration>1</duration>\n');
            case 2
                disp('eighth puase');
                fprintf(output,'<note>\n<rest measure="yes"/>\n<duration>1/2</duration>\n');
            case 1
                disp('sixteenth puase');
                fprintf(output,'<note>\n<rest measure="yes"/>\n<duration>1/4</duration>\n'); 
    end              

end

