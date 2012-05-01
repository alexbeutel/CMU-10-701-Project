function buffers = ConRaster(w,h,X,Y,scores)

% size(X)
F = size(X,1);


buffers = zeros(w,h,F);

scores = -scores;
scores= scores - min(min(scores));
scores = scores / max(max(scores));
% scores = scores - mean(mean(scores));

% figure;
% plot(sort(scores));
% pause

% min(min(score))
% max(max(score))


for frame = 1:F
%     frame
    buffers(:,:,frame) = ConRasterSingleFrame(w,h,X(frame,:),Y(frame,:),scores);
end

end

