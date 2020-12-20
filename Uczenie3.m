clear; clc;

Nazwy = ["Nuty/n1.jpg", "Nuty/n2.jpg", "Nuty/n4.jpg", "Nuty/n8.jpg", "Nuty/n16.png", "Nuty/p1.png", "Nuty/p4.png", "Nuty/p8.png", "Nuty/p16.png", "Nuty/kas.png", "Nuty/krzyzyki.png", "Nuty/bemole.png", "Nuty/k_wiol.png", "Nuty/k_bas.png", "Nuty/m_C.png", "Nuty/m_2_4.png"];
Stopien =0.55; % 0.5 to 0 szumu
LiczbaPowtorzen =5;
[~, LiczbaObiektow] = size(Nazwy);
%----------------------------------------
% im = double(imread(Nazwy(1,3)))/255;
% im = rgb2gray(im);
% im = ~imbinarize(im, .7);
% ex = regionprops(im, "Extrema");
%----------------------------------------
wsp = [];
[~, lNazwy] = size(Nazwy);
for i=1:lNazwy
    wsp = [wsp, funWspUczenie(Nazwy(1, i), LiczbaPowtorzen, Stopien)];
end

[trainin, trainout] = MacierzeDoUczenia(wsp, LiczbaObiektow, 10*LiczbaPowtorzen);

nn = feedforwardnet(100);
nn = train(nn,trainin,trainout);

% nn(trainin(:,[1 41 81 121 161 201 241 281 321 361 401 441 481 521 561 601]))
wynikTestowy = nn(trainin)

% im = rgb2gray(imread("Nuty/NutyZUczenia.png")/255);
% im = imbinarize(im);
% [h,w]=size(im);
% maska3x1 = [0;1;0];
% maska3x3 = [0,0,0;1,1,1;0,0,0];
% maska3x5 = [0,0,0,0,0;1,1,1,1,1;0,0,0,0,0];
% maska3x7 = [0,0,0,0,0,0,0;1,1,1,1,1,1,1;0,0,0,0,0,0,0];
% maska3x9 = [0,0,0,0,0,0,0,0,0;1,1,1,1,1,1,1,1,1;0,0,0,0,0,0,0,0,0];
% newim = FiltrMaskaWzorcowa(im, maska3x1);

% prawidlowe = [6, 7, 11, 12, 13, 14, ...]
% smieci = [...]
%----------------------------------------------------------
% l = bwlabel(im);
% a = regionprops(l, 'all');
% % znak = a(17).Image;
% % imshow(znak);
% for i=1:length(a)
%    nn(wspolczynniki(a(i).Image)') 
% end












