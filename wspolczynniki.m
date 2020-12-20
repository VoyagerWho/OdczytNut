function data = wspolczynniki(im)
    a = regionprops(im, 'Image');
    % orientacie
    % oryginal
    fun = {@blairbliss, @c1, @c2, @circ, @daniellson, @feret, @haralick, @malin, @euler, @perim};%, @extremaPion, @extremaPoziom};
    % ogranicony
    % fun = {@blairbliss, @c1, @c2, @circ, @feret, @haralick, @malin, @euler}; 
    data = zeros(length(a), length(fun));
    for i = 1:length(a)
        for j = 1:length(fun)
            data(i, j) = fun{j}(a(i).Image);
        end
    end
end