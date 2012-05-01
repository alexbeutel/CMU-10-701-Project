function movementBuffer = ConRasterSingleFrame(w,h,X,Y,score)


alpha0 = 150;
alpha = 2*alpha0;



xStamp = ones(alpha0*2+1,1)*(-alpha0:alpha0);
yStamp = (-alpha0:alpha0)'*ones(1,alpha0*2+1);
stamp = exp(-(xStamp.^2+yStamp.^2)/alpha);

n = length(X);

buffer = zeros(w,h);
for k = 1:n,
    x = X(k);
    y = Y(k);
    xRange = max(1-x,-alpha0):min(w-x,alpha0);
    yRange = max(1-y,-alpha0):min(h-y,alpha0);
    substamp = stamp(xRange+alpha0+1,yRange+alpha0+1)*(score(k));
    buffer(xRange+x,yRange+y) = buffer(xRange+x,yRange+y) + substamp;
end

movementBuffer = buffer;

end

