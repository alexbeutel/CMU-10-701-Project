function movementBuffer = ConRasterSingleFrame(w,h,X,Y,score)

prior = 0.5;

n = length(X);

buffer = ones(w,h)*prior;

for k = 1:w,
    for j=1:h,
        [~,i] = min((X-k).^2+(Y-j).^2);
        buffer(k,j) = score(i);
    end
end

movementBuffer = buffer;

end

