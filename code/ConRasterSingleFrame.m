function movementBuffer = ConRasterSingleFrame(w,h,X,Y,score)

prior = 0.5;

n = length(X);

xVals = (1:w)' * ones(1,h);
yVals = ones(w,1) * (1:h);

temp = zeros(w,h,n);
for k = 1:n
    temp(:,:,k) = (xVals - X(k)).^2 + (yVals - Y(k)).^2;
end

[~,minDex] = min(temp,[],3);

movementBuffer = score(minDex);

end

