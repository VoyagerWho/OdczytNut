function filtered = FiltrMaskaWzorcowa(im, Maska)
%FILTRMASKAWZORCOWA Nalazenie maski dopasowujacej do wzorca
%   Nalozenie maski wzorcowej Maska na obraz im i wyzerowanie wartosci
%   spelniajacych wzorzec
    [h, w] = size(im);
    [hM, wM] = size(Maska);
    middle = round([hM/2.0, wM/2.0]);
    offset = [hM, wM] - middle;
    filtered = zeros(h, w);

    for j=1+offset(2):w-offset(2)
        for i=1+offset(1):h-offset(1)
            v=0;
            for y=-offset(1):offset(1)
                for x=-offset(2):offset(2)
                    v = v + abs(im(i+y, j+x)-Maska(middle(1)+y,middle(2)+x));
                end
            end    
            if(v==0)
                filtered(i,j)=0;
            else
                filtered(i,j)=im(i,j);
            end 

        end
    end
end

