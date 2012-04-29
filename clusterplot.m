function clusterPlot(imgfile, W,N, m)

I = imread(imgfile);
F = size(W, 1) / 2;
P = size(W, 2);

X = W(2:F,:);
Y = W(F+(2:F),:);
dX = X(2:(F-1),:) - X(1:(F-2),:);
dY = Y(2:(F-1),:) - Y(1:(F-2),:);
dW = [dX' dY'];

logpdf = zeros(P,1);

for i = 1:m,
gm = gmdistribution.fit(dW,N,'CovType','diagonal','Regularize',0.01);
%gm = gmdistribution.fit(dW,N,'Regularize',0.00001);
[~,~,~,logpdf_i] = cluster(gm, dW);
logpdf = logpdf + logpdf_i;
end
logpdf = logpdf/m;

logpdf = logpdf - min(logpdf);
logpdf = logpdf/max(logpdf);

fprintf('Num frames: %i   Num Traces: %i \n', F, P);

figure;
imshow(I);
hold on;

color = hsv2rgb(logpdf * [0.3 0 0]+ones(size(logpdf))*[0 1 0.8]);

for j=1:P
    %plot(W(1,j), W(F+1,j), 'o', 'Color', colors2(idx(j),:)');
    %plot(dW(j,1:F-4)', dW(j,F-2+(1:F-4))', '-', 'Color', colors(idx(j),:));
    %plot(W(2:F, j), W(F+(2:F), j), '-', 'Color', colors(idx(j),:));
    plot(W(2:F, j), W(F+(2:F), j), '-', 'Color', color(j,:), 'LineWidth', 2);
end
%set(gca,'Position', [0 0 1 1], 'Visible', 'off');
%figure;
%plot(sort(logpdf))
end