function buffers = ConRaster(w,h,X,Y,scores)

% size(X)
F = size(X,1);


buffers = zeros(w,f,F);

for frame = 1:F
%     frame
    buffers(:,:,frame) = ConRasterSingleFrame(w,h,X(frame,:),Y(frame,:),scores);
end

end

