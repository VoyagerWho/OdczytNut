function  saveDatabase(database, sizeOfDatabase)
%SAVEDATABASE Zapis bazy do pliku
% Zapisywane jest:
% baza zawierająca rekordy (struktury) wczytanych nut
% rozmiar bazy

filename = "Data/database.mat";

save( filename, 'database', 'sizeOfDatabase');
end

