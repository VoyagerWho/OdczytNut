clear; clc;

Stopien =0.7;
LiczbaPowtorzen =4;
%nuty
g_n1 = funWspUczenie('n1.jpg', LiczbaPowtorzen, Stopien);
g_n2 = funWspUczenie('n2.jpg', LiczbaPowtorzen, Stopien);
g_n4 = funWspUczenie('n4.jpg', LiczbaPowtorzen, Stopien);
g_n8 = funWspUczenie('n8.jpg', LiczbaPowtorzen, Stopien);
g_n16 = funWspUczenie('n16.png',LiczbaPowtorzen, Stopien);

%pauzy
g_p1 = funWspUczenie('p1.png', LiczbaPowtorzen, Stopien);
% g_p2 = funWspUczenie('p2.jpg', LiczbaPowtorzen, Stopien); %brak obecnie rozróżnienia
g_p4 = funWspUczenie('p4.png', LiczbaPowtorzen, Stopien);
g_p8 = funWspUczenie('p8.png', LiczbaPowtorzen, Stopien);
g_p16 = funWspUczenie('p16.png',LiczbaPowtorzen, Stopien);

%znaki
g_kas = funWspUczenie('kas.png',LiczbaPowtorzen, Stopien);
g_krzyzyki = funWspUczenie('krzyzyki.png',LiczbaPowtorzen, Stopien);
g_bemole = funWspUczenie('bemole.png',LiczbaPowtorzen, Stopien);

%klucze i metrum
g_k_wiol = funWspUczenie('k_wiol.png',LiczbaPowtorzen, Stopien);
g_k_bas = funWspUczenie('k_bas.png',LiczbaPowtorzen, Stopien);
g_m_C = funWspUczenie('m_C.png',LiczbaPowtorzen, Stopien);
g_m_2_4 = funWspUczenie('m_2_4.png',LiczbaPowtorzen, Stopien);

%wielkość - nuty
[h_n1,w_n1] = size(g_n1);
[h_n2,w_n2] = size(g_n2);
[h_n4,w_n4] = size(g_n4);
[h_n8,w_n8] = size(g_n8);
[h_n16,w_n16] = size(g_n16);

%wielkość  - pauzy
[h_p1,w_p1] = size(g_p1);
% [h_p2,w_p2] = size(g_p2); obecnie brak!
[h_p4,w_p4] = size(g_p4);
[h_p8,w_p8] = size(g_p8);
[h_p16,w_p16] = size(g_p16);

%wielkość  - znaki
[h_kas,w_kas] = size(g_kas);
[h_krzyzyki,w_krzyzyki] = size(g_krzyzyki);
[h_bemole,w_bemole] = size(g_bemole);

%wielkość  - klucze i metrum
[h_k_wiol,w_k_wiol] = size(g_k_wiol);
[h_k_bas,w_k_bas] = size(g_k_bas);
[h_m_C,w_m_C] = size(g_m_C);
[h_m_2_4,w_m_2_4] = size(g_m_2_4);

ilosc=2;
zbior = [ g_n1(1:end-ilosc,:); g_n2(1:end-ilosc,:); g_n4(1:end-ilosc,:); g_n8(1:end-ilosc,:);g_n16(1:end-ilosc,:);
    g_kas(1:end-ilosc,:); g_krzyzyki(1:end-ilosc,:); g_bemole(1:end-ilosc,:);
    g_k_wiol(1:end-ilosc,:); g_k_bas(1:end-ilosc,:); g_m_C(1:end-ilosc,:); g_m_2_4(1:end-ilosc,:);]';

LiczbaTypow = 16;
IloscNaTyp = LiczbaPowtorzen*10.*ones(1,LiczbaTypow);
[trainin,trainout] = MacierzeDoUczenia(zbior,LiczbaTypow,IloscNaTyp);

nn = feedforwardnet;
nn = train(nn,trainin,trainout);

testin = [g_n1(end-ilosc+1:end,:);g_n2(end-ilosc+1:end,:);g_n4(end-ilosc+1:end,:);g_n8(end-ilosc+1:end,:);g_n16(end-ilosc+1:end,:);
    g_kas(end-ilosc+1:end,:);g_krzyzyki(end-ilosc+1:end,:);g_bemole(end-ilosc+1:end,:);
    g_k_wiol(end-ilosc+1:end,:);g_k_bas(end-ilosc+1:end,:);g_m_C(end-ilosc+1:end,:);g_m_2_4(end-ilosc+1:end,:);]';

nn(testin)
