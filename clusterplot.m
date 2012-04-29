function clusterPlot(imgfile, W,N)

I = imread(imgfile);
F = size(W, 1) / 2;
P = size(W, 2);

X = W(2:F,:);
Y = W(F+(2:F),:);
dX = X(2:(F-1),:) - X(1:(F-2),:);
dY = Y(2:(F-1),:) - Y(1:(F-2),:);
dW = [dX' dY'];
gm = gmdistribution.fit(dW,N,'CovType','diagonal','Regularize',0.00001);
%gm = gmdistribution.fit(dW,N,'Regularize',0.00001);
idx = cluster(gm, dW);
%idx = ones(1,P);

fprintf('Num frames: %i   Num Traces: %i  idx legnth: %i \n', F, P, length(idx));

colors = [1 0 0; 0 .7 0; 0 0 1; 1 1 0; 1 0 .7; .4 .1 .8; .4 .9 .9; .1 .2 .5];
colors2 = colors/2;

figure;
imshow(I);
hold on;


for j=1:P
    %plot(W(1,j), W(F+1,j), 'o', 'Color', colors2(idx(j),:)');
    %plot(dW(j,1:F-4)', dW(j,F-2+(1:F-4))', '-', 'Color', colors(idx(j),:));
    plot(W(2:F, j), W(F+(2:F), j), '-', 'Color', colors(idx(j),:));
end
%set(gca,'Position', [0 0 1 1], 'Visible', 'off');
end