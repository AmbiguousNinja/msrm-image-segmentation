% Creates a sparse adjacency matrix that only stores values that are
% connected.
% 
% Modified version of REGIONADJACENCY by Peter Kovesi.
% (License below)
%
% Copyright (c) 2013 Peter Kovesi
% Centre for Exploration Targeting
% School of Earth and Environment
% The University of Western Australia
% peter.kovesi at uwa edu au
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
%
function adjMatrix = createAdjacencyMatrix(imageRegions, regions, regionCount, h, w)
    i = zeros(h*w, 1);  % row
    j = zeros(h*w, 1);  % col
    s = zeros(h*w, 1);  % val

    n = 1;
    for (r = 1:h-1)
        i(n) = imageRegions(r,1); j(n) = imageRegions(r  ,2); s(n) = 1; n=n+1;
        i(n) = imageRegions(r,1); j(n) = imageRegions(r+1,1); s(n) = 1; n=n+1;
        i(n) = imageRegions(r,1); j(n) = imageRegions(r+1,2); s(n) = 1; n=n+1;

        for c = 2:w-1
           i(n) = imageRegions(r,c); j(n) = imageRegions(r  ,c+1); s(n) = 1; n=n+1;
           i(n) = imageRegions(r,c); j(n) = imageRegions(r+1,c-1); s(n) = 1; n=n+1;
           i(n) = imageRegions(r,c); j(n) = imageRegions(r+1,c  ); s(n) = 1; n=n+1;
           i(n) = imageRegions(r,c); j(n) = imageRegions(r+1,c+1); s(n) = 1; n=n+1;
        end
    end
    
    adjMatrix = sparse(i, j, s, regionCount, regionCount);
end