function  saveDatabase(database, sizeOfDatabase)
%SAVEDATABASE Saving given database and size of database to a file

filename = "Data/database.mat";

save( filename, 'database', 'sizeOfDatabase');
end

