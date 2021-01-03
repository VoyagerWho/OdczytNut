function Note = noteStruct(id, name, File, rotable)
%creates note structure from *.jpg: resizes, crops image
    im = double(imread(File))/255;
    measurement = regionprops(im, 'Image');
    im = imresize(measurement(1).Image, [128 128]);
    
    Note = struct('Id', id, 'Name', name, 'Image', im, 'Rotable', rotable); 
end