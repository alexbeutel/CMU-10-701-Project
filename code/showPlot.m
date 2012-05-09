function showPlot(imgfile, X, Y, weights)
weights = weights - min(weights);
weights = weights/max(weights);

figure;
I = imread(imgfile);
imshow(I);
hold on;

color = hsv2rgb(weights * [0.3 0 0]+ones(size(weights))*[0 1 0.8]);


% W = [X Y];
% F = size(W, 1) / 2;

plot(X(1,:), Y(1,:), '.g', 'MarkerSize', 20);


for j=1:size(X, 2)
    %plot(W(1,j), W(F+1,j), 'o', 'Color', colors2(idx(j),:)');
    %plot(dW(j,1:F-4)', dW(j,F-2+(1:F-4))', '-', 'Color', colors(idx(j),:));
    %plot(W(2:F, j), W(F+(2:F), j), '-', 'Color', colors(idx(j),:));
    
    
    plot(X(:, j), Y(:, j), '-', 'Color', color(j,:), 'LineWidth', 2);
%     plot(X(:, j), Y(:, j), '-', 'Color', 'b', 'LineWidth', 2);
end

%set(gca,'Position', [0 0 1 1], 'Visible', 'off');
%figure;
%plot(sort(logpdf))
end