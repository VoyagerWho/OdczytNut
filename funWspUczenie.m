function wsp = funWspUczenie(ImNazwa, LiczbaPowtorzen, Stopien)
%FUNWSPUCZENIE wyznaczenie wspolczynnikow dla LiczbyPowtorzen o szumie Stopien
%   Funkcja wyznacza wspolczynniki z powtorzonych LiczbaPowtorzen razy
%   zbioru elementow dodajac szum na poziomie Stopien
    im = double(imread(ImNazwa))/255;
    im = rgb2gray(im);
    im = ~imbinarize(im, .7);

    wsp = [];

    for i=1:LiczbaPowtorzen
       wsp = [wsp, wspolczynniki(imbinarize(DodajSzum(im, Stopien), .7))'];
    end
end

