function IterativeScore()

folder = 'nico/movement1/pgm/window%d/';
part2 = 'image%d.feat.txt';
img = 'nico/movement1/pgm/image%d.pgm';

startFrame = 30;
lastFrame = 79+1;
stepSize = 5;
windowSize = 3;

%do some frame alignment
numsteps = floor((lastFrame-startFrame)/stepSize);

I = imread(sprintf(img,startFrame));

% size(I)

w = size(I,2);
h = size(I,1);

N = 4;
m = 30;

% initialize variables
partialRasters = cell(windowSize,windowSize);
diagIndexes = (1:windowSize) * (windowSize-1) + 1;

% bootstrap and main phase
for step = 1:(numsteps-windowSize),
    
    sf = (step-1) * stepSize + startFrame;
    ef = sf + stepSize * windowSize - 1;
    fn = strcat(sprintf(folder, step-1),part2);
    
    partialRasters(diagIndexes) = clump(BuildRasters(sf,ef,fn,N,m,w,h),windowSize,stepSize); % assign to diagonal
    numLoaded = min(step, windowSize);
    ProcessColumn(partialRasters(windowSize-numLoaded+1:end,1),stepSize,w,h,sf,img); %evaluate the left column    
    partialRasters(:,1:windowSize-1) = partialRasters(:,2:windowSize); %shift left
end

% write out the remaining registers
for step = 1:windowSize-1
    sf = startFrame + (numsteps - windowSize + step)*stepSize;
    ProcessColumn(partialRasters(1:windowSize-step,step),stepSize,w,h,sf,img);
end


end



function ProcessColumn(blockList, stepSize,w,h, startFrame,img)
    numWindows = size(blockList,1)
    for frame = 1:stepSize
        frameStack = zeros(w,h,numWindows);
        for window = 1:numWindows
            frameStack(:,:,window) = blockList{window}(:,:,frame);
        end
        alpha = Combine(frameStack);
        
        alpha = alpha / max(max(alpha));
        I = imread(sprintf(img,frame+startFrame-1));
        I = I';
        imwrite(I,strcat(sprintf(img,frame+startFrame-1),'.png'),'Alpha',alpha); 
        imwrite(alpha,strcat(sprintf(img,frame+startFrame-1),'.alpha.png')); 
    end
end

function confrast = BuildRasters(sf,ef,fn,N,m,w,h)
    fprintf('Import Traces\n')
    W = cvuKltRead(fn,sf,ef);
    fprintf('GMM\n')
    F = size(W,1)/2;
    X = W(1:F,:);
    Y = W(F+(1:F),:);
    logpdf = pickOutliers(X,Y,N,m);
    fprintf('Rasterize\n')
    confrast = ConRaster(w,h,X,Y,logpdf);
    fprintf('Rasterize Done\n')
end

% A groups of size B
function cellArray = clump(mat3,A,B)
    cellArray = cell(1,A);
    for group = 1 : A,
        cellArray{group} = mat3(:,:,((group-1)*B+1:group*B));
    end
end

