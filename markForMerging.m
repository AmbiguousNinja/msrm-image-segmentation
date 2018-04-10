function newRegions = markForMerging(i, j, regions, regionCount)
    newRegions = regions;
    
    if (i > j)
        [j, i] = deal(i, j);
    end
    
    i_s = regions(i).stat;
    j_s = regions(j).stat;
    
    % Case 1: (i unmerged, j unmerged), (i base, j unmerged)
    if (~i_s && ~j_s) || (i_s < 0 && ~j_s)
        newRegions(i).stat = -1;
        newRegions(j).stat = i;
        
    % Case 2: (i unmerged, j base), (i base, j base)
    elseif (~i_s && j_s < 0) || (i_s < 0 && j_s < 0)
        newRegions(i).stat = -1;
        newRegions(j).stat = i;
        
        for (rgnIdx = 1:regionCount)
            if regions(rgnIdx).stat == j
                newRegions(rgnIdx).stat = i;
            end
        end
    
    % Case 3: i unmerged, j merged
    elseif ~i_s && j_s > 0
        if i > j_s
            newRegions(i).stat = j_s;
        elseif i < j_s
            newRegions(i).stat = -1;
            newRegions(j_s).stat = i;
            
            for (rgnIdx = 1:regionCount)
                if regions(rgnIdx).stat == j_s
                    newRegions(rgnIdx).stat = i;
                end
            end
        end
    
    % Case 6: i base, j merged
    elseif i_s < 0 && j > 0
        if i > j_s
            newRegions(i).stat = j_s;
            
            for (rgnIdx = 1:regionCount)
                if regions(rgnIdx).stat == i
                    newRegions(rgnIdx).stat = j_s;
                end
            end
        end
    
    % Case 7: i merged, j base
    elseif i_s > 0 && j_s < 0
        newRegions(j).stat = i_s;
        
        for (rgnIdx = 1:regionCount)
            if regions(rgnIdx).stat == j
                newRegions(rgnIdx).stat = i_s;
            end
        end
        
    % Case 8: i merged, j unmerged
    elseif i_s > 0 && ~j_s
        newRegions(j).stat = i_s;
    
    % Case 9: i merged, j merged
    elseif i_s > 0 && j_s > 0
        if i_s > j_s
            newRegions(i_s).stat = j_s;
            
            for (rgnIdx = 1:regionCount)
                if regions(rgnIdx).stat == i_s
                    newRegions(rgnIdx).stat = j_s;
                end
            end
        elseif i_s > j_s
            newRegions(j_s).stat = i_s;
            
            for (rgnIdx = 1:regionCount)
                if regions(rgnIdx).stat == j_s
                    newRegions(rgnIdx).stat = i_s;
                end
            end
        end
    end
end









