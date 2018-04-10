% Marks regions for merging
function newRegions = markForMerging(i, j, regions, regionCount)
    if (i > j)
        [j, i] = deal(i, j);
    end

    newRegions = regions;
    
    i_s = regions(i).stat;
    j_s = regions(j).stat;
    
    % Case 1: (i unmerged, j unmerged), (i base, j unmerged)
    if (~i_s && ~j_s) || (i_s < 0 && ~j_s)
        newRegions(i).stat = -1;
        newRegions(j).stat = i;
        
    % Case 2: (i unmerged, j base), (i base, j base)
    elseif (~i_s && j_s < 0) || (i_s < 0 && j_s < 0)
        newRegions(i).stat = -1;
        newRegions = markHelper(i, j, newRegions, regionCount);
        
    % Case 3: i unmerged, j merged
    elseif ~i_s && j_s > 0
        if i > j_s
            newRegions(i).stat = j_s;
        elseif i < j_s
            newRegions(i).stat = -1;
            newRegions = markHelper(i, j_s, newRegions, regionCount);
        end
    
    % Case 4: i base, j merged
    elseif i_s < 0 && j > 0
        if i > j_s
            newRegions = markHelper(j_s, i, newRegions, regionCount);
        end
    
    % Case 5: i merged, j unmerged
    elseif i_s > 0 && ~j_s
        newRegions(j).stat = i_s;
        
    % Case 6: i merged, j base
    elseif i_s > 0 && j_s < 0        
        newRegions = markHelper(i_s, j, newRegions, regionCount);

    % Case 7: i merged, j merged
    elseif i_s > 0 && j_s > 0
        if i_s > j_s
            newRegions = markHelper(j_s, i_s, newRegions, regionCount);
        elseif i_s > j_s
            newRegions = markHelper(i_s, j_s, newRegions, regionCount);
        end
    end
end