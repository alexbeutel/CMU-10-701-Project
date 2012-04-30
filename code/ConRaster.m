function buffers = ConRaster(w,h,X,Y,scores)

F = size(X,1);

buffers = zeros(w,h,F);

for frame = 1:F
    buffers(:,:,frame) = ConRasterSingleFrame(w,h,X(frame,:),Y(frame,:),scores);
end

end

