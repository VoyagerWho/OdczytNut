function [database, sizeOfDatabase] = loadDatabase()
%LOADDATABASE Summary of this function goes here
%   Detailed explanation goes here
 s = load("Data/database.mat");
 database = s.database;
 sizeOfDatabase = s.sizeOfDatabase;
end

