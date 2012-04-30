function movementBuffer = ConRasterSingleFrame(w,h,X,Y,score)

prior = 0.5;

n = length(X);

buffer = zeros(w,h);
for k = 1:n,
    x = X(k);
    y = Y(k);
    xRange = max(1,x-20):min(w,x+20);
    yRange = max(1,y-20):min(h,y+20);
    buffer(xRange,yRange) = buffer(xRange,yRange) + 0.01;
end

movementBuffer = buffer;

end

