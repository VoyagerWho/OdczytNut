clear;clc;close all;
%CREATE DATABASE - matrix of note structs

Files = ["Nuty/whole.jpg", "Nuty/whole_1on.jpg", "Nuty/whole_1under.jpg", "Nuty/half.jpg", "Nuty/half_1on.jpg", "Nuty/half_1under.jpg", "Nuty/half_2on.jpg", "Nuty/half_2under.jpg", "Nuty/half_3on.jpg", "Nuty/half_3under.jpg", "Nuty/quarter.jpg", "Nuty/quarter_1on.jpg", "Nuty/quarter_1under.jpg", "Nuty/quarter_2on.jpg", "Nuty/quarter_2under.jpg", "Nuty/quarter_3on.jpg", "Nuty/quarter_3under.jpg", "Nuty/eighth.jpg",  "Nuty/eighth_rot.jpg", "Nuty/eighth_1on.jpg", "Nuty/eighth_1on_rot.jpg", "Nuty/eighth_1under.jpg",  "Nuty/eighth_1under_rot.jpg", "Nuty/eighth_2on.jpg", "Nuty/eighth_2on_rot.jpg", "Nuty/eighth_2under.jpg", "Nuty/eighth_2under_rot.jpg", "Nuty/eighth_3on.jpg", "Nuty/eighth_3on_rot.jpg", "Nuty/eighth_3under.jpg", "Nuty/eighth_3under_rot.jpg", "Nuty/sixteenth.jpg", "Nuty/sixteenth_rot.jpg", "Nuty/sixteenth_1on.jpg", "Nuty/sixteenth_1on_rot.jpg", "Nuty/sixteenth_1under.jpg", "Nuty/sixteenth_1under_rot.jpg", "Nuty/sixteenth_2on.jpg", "Nuty/sixteenth_2on_rot.jpg", "Nuty/sixteenth_2under.jpg", "Nuty/sixteenth_2under_rot.jpg", "Nuty/sixteenth_3on.jpg", "Nuty/sixteenth_3on_rot.jpg", "Nuty/sixteenth_3under.jpg", "Nuty/sixteenth_3under_rot.jpg", "Nuty/whole_pause.jpg", "Nuty/quarter_pause.jpg", "Nuty/eighth_pause.jpg", "Nuty/sixteenth_pause.jpg", "Nuty/natural.jpg", "Nuty/sharp.jpg", "Nuty/flat.jpg", "Nuty/G_key.jpg", "Nuty/F_key.jpg", "Nuty/metre_C.jpg"];
Names = ["whole", "whole", "whole", "half", "half", "half", "half", "half", "half", "half", "quarter", "quarter", "quarter", "quarter", "quarter", "quarter", "quarter", "eighth", "eighth", "eighth", "eighth", "eighth", "eighth", "eighth", "eighth", "eighth", "eighth", "eighth", "eighth", "eighth", "eighth", "sixteenth", "sixteenth", "sixteenth", "sixteenth", "sixteenth", "sixteenth", "sixteenth", "sixteenth", "sixteenth", "sixteenth", "sixteenth", "sixteenth", "sixteenth", "sixteenth", "whole_pause", "quarter_pause", "eighth_pause", "sixteenth_pause", "natural", "sharp", "flat", "G key", "F key", "C metre"];
Rotation = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
Ids = [1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,5,6,7,8,9,10,11,12,13,14,15];
[~, Files_length] = size(Files);
NoteDatabase = [];

for i = 1:Files_length
    NoteDatabase = addRecord(NoteDatabase, noteStruct(Ids(1,i),Names(1,i),Files(1,i),Rotation(1,i))); 
end    

for i=1:Files_length
   subplot(8,8,i);
   imshow(NoteDatabase(i).Image);
end

saveDatabase(NoteDatabase, Files_length);