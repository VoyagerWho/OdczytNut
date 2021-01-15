function Note = noteStruct(id, name, File, rotable, height)
%creates note structure from *.jpg: resizes, crops image
    im = double(rgb2gray(imread(File)))/255;
    im = imbinarize(im, 0.9);
    measurement = regionprops(im, 'Image');
    im = imresize(measurement(1).Image, [128 64]);
    
    Note = struct('Id', id, 'Name', name, 'Image', im, 'Rotable', rotable, 'Height', height); 
end