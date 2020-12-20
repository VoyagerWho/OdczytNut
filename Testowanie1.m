clear; clc;

nn = load("network.mat");

im = rgb2gray(imread("Nuty/NutyZUczenia.png")/255);
im = imbinarize(im);
% [h,w]=size(im);
% maska3x1 = [0;1;0];
% maska3x3 = [0,0,0;1,1,1;0,0,0];
% maska3x5 = [0,0,0,0,0;1,1,1,1,1;0,0,0,0,0];
% maska3x7 = [0,0,0,0,0,0,0;1,1,1,1,1,1,1;0,0,0,0,0,0,0];
% maska3x9 = [0,0,0,0,0,0,0,0,0;1,1,1,1,1,1,1,1,1;0,0,0,0,0,0,0,0,0];
% newim = FiltrMaskaWzorcowa(im, maska3x1);

% prawidlowe = [6, 7, 11, 12, 13, 14, ...]
% smieci = [...]
% ----------------------------------------------------------
l = bwlabel(im);
a = regionprops(l, 'all');
% znak = a(17).Image;
% imshow(znak);
wynik = [];
for i=1:length(a)
   wynik = [wynik, nn.nn(wspolczynniki(a(i).Image)')];
end
imshow(label2rgb(l));
wynik

a = [(wspolczynniki(a(7).Image))',(wspolczynniki(a(8).Image))',(wspolczynniki(a(9).Image))',(wspolczynniki(a(10).Image))']