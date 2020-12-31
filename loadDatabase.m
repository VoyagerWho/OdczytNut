function [database, sizeOfDatabase] = loadDatabase()
%LOADDATABASE Loading database and size of database
 s = load("Data/database.mat");
 database = s.database;
 sizeOfDatabase = s.sizeOfDatabase;
end

