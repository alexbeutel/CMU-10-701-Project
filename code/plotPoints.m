function plotPoints(images, sFrame, W)

F = size(W, 1) / 2;
P = size(W, 2);

figure;
for i = 1:16
    
    subplot(4,4,i);
    
    I = imread(sprintf(images, i+sFrame-1));
    imshow(I);
    hold on;
    
    plot(W(i, :), W(F+i, :), '.y');

%     W(i+1-sFrame, :, :) = load(sprintf(format, i));
end

end