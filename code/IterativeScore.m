function IterativeScore()

folder = 'nico/movement1/pgm/window%d/';
part2 = 'image%d.feat.txt';
img = 'nico/movement1/pgm/image%d.pgm';

startFrame = 30;
lastFrame = 79+1;
stepSize = 5;
windowSize = 3;

%do some frame alignment
F = stepSize*windowSize;
numSteps = floor((lastFrame-startFrame)/stepSize);

I = imread(sprintf(img,startFrame));

w = size(I,2);
h = size(I,1);

N = 4;
m = 100;

% initialize variables
partialRasters = cell(windowSize,windowSize);
diagIndexes = (1:windowSize) * (windowSize-1) + 1;

% bootstrap and main phase
for step = 1:(numsteps-windowSize),
    partialRasters(diagIndexes) = clump(BuildRasters(),windowSize,stepSize); % assign to diagonal
    numLoaded = min(step, windowSize);
    ProcessColumn(partialRasters(windowSize-numLoaded+1:end,1)); %evaluate the left column    
    partialRasters(:,1:windowSize-1) = partialRasters(:,2:windowSize); %shift left
end

% write out the remaining registers
for step = 1:windowSize-1
    ProcessColumn(partialRasters(1:windowSize-step,step))
end

fprintf('Combine and post process\n')

alphas = Combine(rasters);

for i = 1:lastFrame-startFrame
    a = alphas{i};
    
    I = imread(sprintf(img,i+startFrame));
    
    imwrite(I,concat(sprintf(img,i+startFrame),'.png'),'Alpha',a); 
end


end

function ProcessColumn(blockList, stepSize)
    numWindows = length(blockList);
    for frame = 1:stepSize
        frameStack = zeros(w,h,numWindows);
        for window = 1:numWindows
            frameStack(window) = blockList{window}(:,:,frame);
        end
        Combine(frameStack); % GOTTA DO SOMETHING WITH THIS
    end
end

function confrast = BuildRasters()
    fprintf('Import Traces\n')
    W = cvuKltRead(strcat(sprintf(folder, cnt),part2),sf,ef);
    fprintf('GMM and Rasterize\n')
    X = W(1:F,:);
    Y = W(F+(1:F),:);
    logpdf = pickOutliers(X,Y,N,m);
    confrast = ConRaster(w,h,X,Y,logpdf);
end

% A groups of size B
function cellArray = clump(mat3,A,B)
    cellArray = cell(A);
    for group = 1 : A,
        cellArray{group} = mat3(:,:,((group-1)*B+1:group*B));
    end
end

