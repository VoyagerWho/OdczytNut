 function Matrix2XML(Database, sizeOfDatabase, staves, fifths, transpose)
%Function transforming noteDecs data into MusicXML: 
%Notedatabase - notes and objects matrix; size - numbers of obcjets recognized
%Clefdatabase - clefs on staves, staves - number of staves
%fifths - number of fifths next to clef (tonation)
%beats, beattype - metre
%measuremax - number of bars

[NoteDatabase, size, ClefDatabase, beats, beattype, measuremax] = noteDesc2ClefNote(Database, sizeOfDatabase, transpose);
parts = 1; %% number of parts
measure = 1;

for i = 1:staves
    time{i} = [beats];
end

output = fopen("music.xml", "w");
fprintf(output,'<?xml version="1.0" encoding="UTF-8"?>\n <!DOCTYPE score-partwise PUBLIC "-//Recordare//DTD MusicXML 3.1 Partwise//EN" "http://www.musicxml.org/dtds/partwise.dtd">\n <score-partwise version="3.1"> \n');

fprintf(output,'<part-list>\n');
for p = 1:parts
    fprintf(output,'<score-part id="P%d">\n<part-name>Line%d</part-name>\n</score-part>\n',p,p);
end
fprintf(output,'</part-list>\n');

for p = 1:parts
    fprintf(output,'<part id="P%d">\n',p);
    fprintf(output,'<measure number="1">\n<attributes>\n<divisions>1</divisions>\n<key>\n<fifths>%d</fifths>\n</key>\n<time>\n<beats>%d</beats>\n<beat-type>%d</beat-type>\n</time>\n<staves>%d</staves>\n',fifths, beats, beattype, staves);
    for s = 1:staves
        fprintf(output,'<clef number="%d">\n<sign>%c</sign>\n<line>%d</line>\n</clef>\n', s, getRecord(ClefDatabase,s).Name, getRecord(ClefDatabase,s).Height);
    end
    s=1;
    fprintf(output,'</attributes>\n');
        
    for i = 1:size                 
        switch getRecord(NoteDatabase,i).Id
            case 1
                disp('whole');
                fprintf(output,'<note>\n<pitch>\n<step>%c</step>\n<alter>%d</alter>\n<octave>%d</octave>\n</pitch>\n<duration>4</duration>\n<type>whole</type>\n', getRecord(NoteDatabase,i).Step, getRecord(NoteDatabase,i).Alter, getRecord(NoteDatabase,i).Octave);
                time{s} = time{s} - beattype;
            case 2
                disp('half');
                fprintf(output,'<note>\n<pitch>\n<step>%c</step>\n<alter>%d</alter>\n<octave>%d</octave>\n</pitch>\n<duration>2</duration>\n<type>half</type>\n', getRecord(NoteDatabase,i).Step, getRecord(NoteDatabase,i).Alter, getRecord(NoteDatabase,i).Octave);
                time{s} = time{s} - beattype*(1/2);
            case 3
                disp('quarter');
                fprintf(output,'<note>\n<pitch>\n<step>%c</step>\n<alter>%d</alter>\n<octave>%d</octave>\n</pitch>\n<duration>1</duration>\n<type>quarter</type>\n', getRecord(NoteDatabase,i).Step, getRecord(NoteDatabase,i).Alter, getRecord(NoteDatabase,i).Octave);
                time{s} = time{s} - beattype*(1/4);
            case 4
                disp('eighth');
                fprintf(output,'<note>\n<pitch>\n<step>%c</step>\n<alter>%d</alter>\n<octave>%d</octave>\n</pitch>\n<duration>1/2</duration>\n<type>eighth</type>\n', getRecord(NoteDatabase,i).Step, getRecord(NoteDatabase,i).Alter, getRecord(NoteDatabase,i).Octave);
                time{s} = time{s} - beattype*(1/8);                          
            case 5
                disp('sixteenth');
                fprintf(output,'<note>\n<pitch>\n<step>%c</step>\n<alter>%d</alter>\n<octave>%d</octave>\n</pitch>\n<duration>1/4</duration>\n<type>sixteenth</type>\n', getRecord(NoteDatabase,i).Step, getRecord(NoteDatabase,i).Alter, getRecord(NoteDatabase,i).Octave);
                time{s} = time{s} - beattype*(1/16); 
            case 6
                disp('whole puase');
                fprintf(output,'<note>\n<rest measure="yes"/>\n<duration>4</duration>\n');
                time{s} = time{s} - beattype;
            case 7
                disp('half puase');
                fprintf(output,'<note>\n<rest measure="yes"/>\n<duration>2</duration>\n');
                time{s} = time{s} - beattype*(1/2);
            case 8
                disp('quarter puase');
                fprintf(output,'<note>\n<rest measure="yes"/>\n<duration>1</duration>\n');
                time{s} = time{s} - beattype*(1/4);
            case 9
                disp('eighth puase');
                fprintf(output,'<note>\n<rest measure="yes"/>\n<duration>1/2</duration>\n');
                time{s} = time{s} - beattype*(1/8);
            case 10
                disp('sixteenth puase');
                fprintf(output,'<note>\n<rest measure="yes"/>\n<duration>1/4</duration>\n');
                time{s} = time{s} - beattype*(1/16);        
                 
            otherwise
                disp('ERROR: obejct not detected');                       
        end
        if getRecord(NoteDatabase,i).Alter == 1
            fprintf(output,'<accidental>sharp</accidental>\n');
        elseif getRecord(NoteDatabase,i).Alter == -1
            fprintf(output,'<accidental>flat</accidental>\n');
        end    
        if getRecord(NoteDatabase,i).Rotated == 1
            fprintf(output,'<stem>down</stem>\n');
        end 
        fprintf(output,'<staff>%d</staff>\n</note>\n',s);
        if time{s}==0 
            if s==staves
                if measure==measuremax
                    fprintf(output,'<barline location="right">\n<bar-style>light-heavy</bar-style>\n</barline>\n');
                    break;
                else
                    s = 1;
                    measure = measure + 1;
                    for j = 1:staves
                        time{j} = [beats];
                    end
                    fprintf(output,'</measure>\n<measure number="%d">',measure);
                end        
            else
                s = s+1;
                fprintf(output,'<backup>\n<duration>%d</duration>\n</backup>',beattype);
            end      
        end   
    end
       
    fprintf(output,'</measure>\n</part>\n');
    measure = 1;
    for j = 1:staves
        time{j} = [beats];
    end
end

fprintf(output,'</score-partwise>');
fclose(output);

end
