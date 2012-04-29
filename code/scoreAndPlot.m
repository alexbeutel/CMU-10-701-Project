function scoreAndPlot(imgfile, W, N, m)
F = size(W, 1) / 2;
P = size(W, 2);

X = W(2:F,:);
Y = W(F+(2:F),:);
logpdf = pickOutliers(X,Y,N,m);

showPlot(imgfile,X,Y,logpdf);

end