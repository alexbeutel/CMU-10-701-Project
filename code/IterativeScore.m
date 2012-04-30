function IterativeScore()

folder = 'nico/movement1/pgm/window%d/';
part2 = 'image%d.feat.txt';
img = 'nico/movement1/pgm/image%d.pgm';

startFrame = 30;
lastFrame = 80;
stepSize = 5;
windowSize = 3;


I = imread(sprintf(img,startFrame));

w = size(I,2);
h = size(I,1);

N = 4;
m = 100;


% indexed by frame number
% with a vector of rasters for each frame

% i just want the fucking push command
rasters = cell(1, windowSize * stepSize );


cnt = 0;
for i = startFrame:stepSize:lastFrame
    
    fprintf('Window %d at frame %d\n',cnt,i)
    
    sf = i;
    ef = min(lastFrame, sf + stepSize * windowSize - 1);
    
    
    fprintf('Import Traces\n')
    W = cvuKltRead(strcat(sprintf(folder, cnt),part2),sf,ef);
    cnt = cnt+1;

    
    fprintf('GMM\n')
    F = size(W, 1) / 2;
    P = size(W, 2);

    X = W(1:F,:);
    Y = W(F+(1:F),:);
    logpdf = pickOutliers(X,Y,N,m);

    
    fprintf('ConRast\n')
    confrast = ConRaster(w,h,X,Y,logpdf);
    

    fprintf('Save Rasters\n')
    for j = 1:F
       r = confrast(:,:,j);
       
       if(size(rasters{j+startFrame},1) == 0)
           rasters{j+startFrame} = r;
       else
           rasters{j+startFrame}(:,:,size(rasters{j+startFrame},3)+1) = r;
       end
        
    end
    
    
end

fprintf('Combine and post process\n')

alphas = Combine(rasters);

for i = 1:lastFrame-startFrame
    a = alphas{i};
    
    I = imread(sprintf(img,i+startFrame));
    
    imwrite(I,concat(sprintf(img,i+startFrame),'.png'),'Alpha',a); 
end


end