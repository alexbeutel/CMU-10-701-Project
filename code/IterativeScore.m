function IterativeScore()

folder = 'nico/movement1/pgm/window%d/';
part2 = 'image%d.feat.txt';
img = 'nico/movement1/pgm/image%d.pgm';

startFrame = 30;
lastFrame = 80;
stepSize = 5;
windowSize = 3;

N = 4;
m = 100;


cnt = 0;
for i = startFrame:stepSize:lastFrame
    
    % Import Traces
    sf = i;
    ef = min(lastFrame, sf + stepSize * windowSize);
    
    W = cvuKltRead(strcat(sprintf(folder, cnt),part2),sf,ef);
    cnt = cnt+1;
    

    scoreAndPlot2(sprintf(img,sf), W, N, m);
    
%     % Score
%     F = size(W, 1) / 2;
%     P = size(W, 2);
% 
%     X = W(2:F,:);
%     Y = W(F+(2:F),:);
%     logpdf = pickOutliers(X,Y,N,m);

end


end