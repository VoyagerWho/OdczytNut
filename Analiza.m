Nazwy = ["Nuty/n1.jpg", "Nuty/n2.jpg", "Nuty/n4.jpg", "Nuty/n8.jpg", "Nuty/n16.png", "Nuty/p1.png", "Nuty/p4.png", "Nuty/p8.png", "Nuty/p16.png", "Nuty/kas.png", "Nuty/krzyzyki.png", "Nuty/bemole.png", "Nuty/k_wiol.png", "Nuty/k_bas.png", "Nuty/m_C.png", "Nuty/m_2_4.png"];
Stopien =0.55; % 0.5 to 0 szumu
LiczbaPowtorzen =10;
[~, LiczbaObiektow] = size(Nazwy);

% -----------Analiza---------------------
[Avr, Range] = AnalizaDanych(Nazwy, LiczbaPowtorzen, Stopien);
% NazwyWsp = ["Nuta";"blairbliss"; "c1"; "c2"; "circ"; "daniellson"; "feret"; "haralick"; "malin"; "euler"; "perim"; "extremaPion"; "extremaPoziom"];
NazwyWsp = ["Nuta";"blairbliss"; "c1"; "c2"; "circ"; "feret"; "haralick"; "malin"; "euler"];

AD = [Nazwy; Avr];
AD = [NazwyWsp, AD];
Range = [Nazwy; Range];
Range = [NazwyWsp, Range];