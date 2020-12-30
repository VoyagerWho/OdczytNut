function Note = noteStruct(id, name, File, rotable)
%creates note structure from *.jpg: resizes, crops image
    im = double(imread(File))/255;
    im = ~imbinarize(rgb2gray(im));
    measurement = regionprops(im, 'Image');
    im = imresize(measurement(1).Image, [128 128]);
    if(id == 2)
        im = imrotate(im, 180);
    end
    Note = struct('Id', id, 'Name', name, 'Image', im, 'Rotable', rotable); 
end