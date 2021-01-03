clear;clc;
%CREATE DATABASE - matrix of note structs

Files = ["Nuty/whole.jpg", "Nuty/half.jpg", "Nuty/quarter.jpg", "Nuty/eighth.jpg", "Nuty/eighth_rot.jpg", "Nuty/sixteenth.jpg", "Nuty/sixteenth_rot.jpg", "Nuty/whole_pause.jpg", "Nuty/quarter_pause.jpg", "Nuty/eighth_pause.jpg", "Nuty/sixteenth_pause.jpg", "Nuty/natural.jpg", "Nuty/sharp.jpg", "Nuty/flat.jpg", "Nuty/G_key.jpg", "Nuty/F_key.jpg", "Nuty/metre_C.jpg"];
Names = ["whole", "half", "quarter", "eighth", "eighth", "sixteenth", "sixteenth", "whole_pause", "quarter_pause", "eighth_pause", "sixteenth_pause", "natural", "sharp", "flat", "G key", "F key", "C metre"];
Rotation = [true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
Ids = [1,2,3,4,4,5,5,6,7,8,9,10,11,12,13,14,15];
[~, Files_length] = size(Files);
NoteDatabase = [];

for i = 1:Files_length
    NoteDatabase = addRecord(NoteDatabase, noteStruct(Ids(1,i),Names(1,i),Files(1,i),Rotation(1,i))); 
end    

saveDatabase(NoteDatabase, Files_length);