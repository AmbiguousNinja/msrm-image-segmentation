% Updates regions marked for merging into region j with region i
function newRegions = markHelper(i, j, regions, regionCount)
    newRegions = regions;
    newRegions(j).stat = i;
    
    for (idx = 1:regionCount)
        if regions(idx).stat == j
            newRegions(idx).stat = i;
        end
    end
end