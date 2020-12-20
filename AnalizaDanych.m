function [wspolczynniki, odchylenia] = AnalizaDanych(Nazwy, LiczbaPotorzen, Stopien)
%ANALIZADANYCH Summary of this function goes here
%   Detailed explanation goes here
    [~ , liczbaNazw] = size(Nazwy);
    wspolczynniki = [];
    odchylenia = [];
    for i=1:liczbaNazw
        wspZbior = funWspUczenie(Nazwy(1, i), LiczbaPotorzen, Stopien);
        wspAvr = mean(wspZbior,2);
        wspOdch = (max(wspZbior,[],2) - min(wspZbior,[],2))/2;
        wspolczynniki = [wspolczynniki, wspAvr];
        odchylenia = [odchylenia, wspOdch];
    end
end

