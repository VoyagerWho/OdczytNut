function [TrainIn, TrainOut] = MacierzeDoUczenia(ZbiorTypow, LiczbaTypow, IloscNaTyp)
%MACIERZEDOUCZENIA Przygotowanie macierzy do uczenie sieci
%   Funkcja przygotowujaca miaczierze pod uczenie sieci neuronowych 
    TrainIn = ZbiorTypow;
    TrainOut = zeros(LiczbaTypow, LiczbaTypow*IloscNaTyp);
    for i=1:LiczbaTypow
       TrainOut(i, IloscNaTyp*(i-1)+1:IloscNaTyp*i) = 1;
    end
end

