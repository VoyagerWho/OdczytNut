function Notes = DodajSzum(im, Stopien)
%DODAJSZUM Dodanie lekkiego szumu do krawedzi
%   Dodanie szumu do krawedzi im o stopniu zaszumienia Stopien
   [h, w] = size(im);
   Notes=im+((imdilate(im,ones(3))-im).*round(rand(h,w)*Stopien));
%    Notes = Notes.*(Notes-imerode(Notes,ones(3)).*round(rand(h,w)*Stopien));
   Notes=imclose(Notes,ones(2));
end
