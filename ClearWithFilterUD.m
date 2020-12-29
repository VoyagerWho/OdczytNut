function filtered = ClearWithFilterUD(im, pos, filter)
%CLEARWITHFILTERUD Clear image based on filter
%   Clearing lines on image at exact position that math to filter 
    [h, w] = size(im);
    [hF, wF] = size(filter);
    middle = round([hF/2.0, wF/2.0]);
    offset = [hF, wF] - middle;
    
    for i = pos
        for j=1+offset(2):w-offset(2)
            v=0;
            for y=-offset(1):offset(1)
                for x=-offset(2):offset(2)
                    v = v + abs(im(i+y, j+x)-filter(middle(1)+y,middle(2)+x));
                end
            end    
            if(v==0)
                im(i,j)=0;
            end
        end
    end
    filtered = im;
end

