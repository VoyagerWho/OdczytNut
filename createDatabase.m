clear;clc;
%CREATE DATABASE - array of note structs

Files = ["Nuty/whole.jpg", "Nuty/half.jpg", "Nuty/quarter.jpg", "Nuty/eighth.jpg", "Nuty/sixteenth.jpg", "Nuty/whole_pause.jpg", "Nuty/quarter_pause.jpg", "Nuty/eighth_pause.jpg", "Nuty/sixteenth_pause.jpg", "Nuty/natural.jpg", "Nuty/sharp.jpg", "Nuty/flat.jpg", "Nuty/G_key.jpg", "Nuty/F_key.jpg", "Nuty/metre_C.jpg", "Nuty/metre_2_4.jpg"];
Names = ["whole", "half", "quarter", "eighth", "sixteenth", "whole_pause", "quarter_pause", "eighth_pause", "sixteenth_pause", "natural", "sharp", "flat", "G key", "F key", "C metre", "2/4 metre"];
Rotation = [true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false];
[~, Files_length] = size(Files);
NoteDatabase = {Files_length};

for i = 1:Files_length
    Note = noteStruct(i,Names(1,i),Files(1,i),Rotation(1,i));
    NoteDatabase{i} = Note; 
end    

saveDatabase(NoteDatabase, Files_length);