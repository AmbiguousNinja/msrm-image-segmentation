% Helper function for marking regions to merge
function newRegions = markHelper(i, j, regions, regionCount)
    newRegions = regions;
    newRegions(j).stat = i;
    
    for (idx = 1:regionCount)
        if regions(idx).stat == j
            newRegions(idx).stat = i;
        end
    end
end