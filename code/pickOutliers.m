function logpdf = pickOutliers(X, Y, N, m)

F = size(X, 1);
P = size(X, 2);

dX = X(2:F,:) - X(1:(F-1),:);
dY = Y(2:F,:) - Y(1:(F-1),:);
dW = [dX' dY'];

% delete columns with all 0s
dW = dW(:, sum(abs(dW) > 0,1) > 0);
% size(dW)

logpdf = zeros(P,1);

for i = 1:m,
gm = gmdistribution.fit(dW,N,'CovType','diagonal','Regularize',0.01);
%gm = gmdistribution.fit(dW,N,'Regularize',0.00001);
[~,~,~,logpdf_i] = cluster(gm, dW);
logpdf = logpdf + logpdf_i;
end
logpdf = logpdf/m;

end