function Note = noteStruct(id, name, File, rotable)
%creates note structure from *.jpg: resizes, crops image
    im = double(imread(File))/255;
    im = ~imbinarize(rgb2gray(im), .2);
    measurement = regionprops(im, 'BoundingBox');
    im = imresize(imcrop(im, measurement.BoundingBox), [128 128]);
   
    Note = struct('Id', id, 'Name', name, 'Image', im, 'Rotable', rotable); 
end