function alphas = Combine(rasters)

% alphas = (sum(rasters,3) > 0) + 0.0;
alphas = sum(rasters,3);

end