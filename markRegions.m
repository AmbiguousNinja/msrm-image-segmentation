% Mark regions for merging
function [regions, marked] = markRegions(similarities, regions, regionCount, regionType)
    marked = 0;
    
    [i, j, v] = find(similarities);

    for k = 1:size(i, 1)
        rgn1 = i(k);
        rgn2 = j(k);
        
        if (regions(rgn1).type ~= regionType || rgn1 == rgn2 || regions(rgn2).type ~= 0)
            continue;
        end
        
        max = -1;
        maxIdx = -1;
        
        for l = 1:size(i, 1)
            
            if j(l) == i(l)
                continue;
            end
            
            if j(l) == rgn2 && v(l) > max
                max = v(l);
                maxIdx = i(l);
            end
        end
        
        if rgn1 == maxIdx
            regions = mark(rgn1, rgn2, regions, regionCount);
            marked = 1;
        end
    end
end