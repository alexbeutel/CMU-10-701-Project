function buffer = ConRasterSingleFrame(w,h,X,Y,score)

% alpha1 = 400;
% alpha2 = 200;

alpha1 = 60;
alpha2 = 30;

beta1 = 0.0;
beta2 = 0.0;

stampSize = 4;

buffer = zeros(w,h);

for sx = 1:floor(w/stampSize),
    for sy = 1:floor(h/stampSize),
        x = (sx-0.5)*stampSize;
        y = (sy-0.5)*stampSize;
        xRange = (sx-1)*stampSize+1:min(sx*stampSize,w);
        yRange = (sy-1)*stampSize+1:min(sy*stampSize,h);
        
        ss = sort(score);
        thresh = ss( round( 0.6 * length(ss) ) );

        kappa1 = sigmoid( (score - thresh) * 100 );
        kappa2 = 1 - kappa1;
        delta1 = 1-exp(-((X-x).^2+(Y-y).^2)/alpha1);
        delta2 = 1-exp(-((X-x).^2+(Y-y).^2)/alpha2);
        logprob1 = sum(log(beta1*delta1 + (1-delta1).*kappa1' + 0.00001));
        logprob2 = sum(log(beta2*delta2 + (1-delta2).*kappa2' + 0.00001));        
        buffer(xRange,yRange) = logprob1 - logprob2;
    end
end

end

% alpha0 = 150;
% alpha = 2*alpha0;
% 
% 
% 
% xStamp = ones(alpha0*2+1,1)*(-alpha0:alpha0);
% yStamp = (-alpha0:alpha0)'*ones(1,alpha0*2+1);
% stamp = exp(-(xStamp.^2+yStamp.^2)/alpha);
% 
% n = length(X);
% 
% buffer = zeros(w,h);
% for k = 1:n,
%     x = X(k);
%     y = Y(k);
%     xRange = max(1-x,-alpha0):min(w-x,alpha0);
%     yRange = max(1-y,-alpha0):min(h-y,alpha0);
%     substamp = stamp(xRange+alpha0+1,yRange+alpha0+1)*(score(k));
%     buffer(xRange+x,yRange+y) = buffer(xRange+x,yRange+y) + substamp;
% end
% 
% movementBuffer = buffer;

function a = sigmoid(z)
a = 1.0 ./ (1.0 + exp(-z));
end
