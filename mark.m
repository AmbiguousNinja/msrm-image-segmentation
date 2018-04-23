% Marks regions for merging
function newRegions = mark(i, j, regions, regionCount)
    
% Choose smaller region index as the 'base' for merging
    if (i > j)
        [j, i] = deal(i, j);
    end

    newRegions = regions;
    
    newRegions(i).stat = -1;
    newRegions(j).stat = i;
end