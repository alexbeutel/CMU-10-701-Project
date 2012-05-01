function scoreAndPlot2( sf, ef, N, m, imgfile, fn)

W = cvuKltRead(fn,sf,ef);

F = size(W, 1) / 2;
P = size(W, 2);

X = W(1:F,:);
Y = W(F+(1:F),:);
logpdf = pickOutliers(X,Y,N,m);



% Remove outliers
% figure;
slogpdf = sort(logpdf);
% plot(slogpdf);

thresh = slogpdf( round( 0.5 * P ) );

X2 = X(:, logpdf < thresh);
Y2 = Y(:, logpdf < thresh);
logpdf2 = logpdf( logpdf < thresh );


logpdf3 = pickOutliers(X2,Y2,N,m);

slogpdf = sort(logpdf3);
thresh = slogpdf( round( 0.1 * length(slogpdf) ) );

X3 = X(:, logpdf < thresh);
Y3 = Y(:, logpdf < thresh);
logpdf4 = logpdf( logpdf < thresh );



% X3 = X(:,1:round(0.9*P));
% Y3 = Y(:,1:round(0.9*P));

% figure;
% plot(sort(logpdf2));


oldW = [X Y];
oldW = oldW - mean(oldW,2)*ones(1,size(oldW,2));
[~,S,~] = svd(oldW);
s1 = diag(S);

newW = [X2 Y2];
newW = newW - mean(newW,2)*ones(1,size(newW,2));
[~,S,~] = svd(newW);
s2 = diag(S);

% newW2 = [X3 Y3];
% newW2 = newW2 - mean(newW2,2)*ones(1,size(newW2,2));
% [~,S,~] = svd(newW2);
% s3 = diag(S);


s1(1)/sum(s1(4:end))
s2(1)/sum(s2(4:end))
% s3(1)/sum(s3(4:end))

% [s1(1:10) s2(1:10)]



showPlot(imgfile,X,Y,logpdf);
showPlot(imgfile,X2,Y2,logpdf3);
showPlot(imgfile,X3,Y3,logpdf4);
% showPlot(imgfile,X2,Y2,logpdf2);

end