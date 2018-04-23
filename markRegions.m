% Mark regions for merging
function [regions, marked] = markRegions(similarities, regions, regionCount, regionType)
    marked = 0;
    
    % Get adjacency information
    [i, j, v] = find(similarities);
    
    % Check adjacency matrix for adjacent regions.
    for k = 1:size(i, 1)
        rgn1 = i(k);
        rgn2 = j(k);
        
        % If the region is not in our desired set, 'regionType' or the
        % adjacent region is not in the unmarked set (N), skip this set of
        % regions.
        if (regions(rgn1).type ~= regionType || rgn1 == rgn2 || regions(rgn2).type ~= 0)
            continue;
        end
        
        max = -1;
        maxIdx = -1;
        
        % Find the most similar region adjacent to the adjacent region. 
        for l = 1:size(i, 1)
            if j(l) == i(l)
                continue;
            end
            
            if j(l) == rgn2 && v(l) > max
                max = v(l);
                maxIdx = i(l);
            end
        end
        
        % If the most similar region is our initial region, mark the
        % regions for merging
        if rgn1 == maxIdx
            % Choose smaller region index as the 'base' for merging
            if (rgn1 > rgn2)
                [rgn2, rgn1] = deal(rgn1, rgn2);
            end
            
            regions(rgn1).stat = -1;
            regions(rgn2).stat = rgn1;
            
            marked = 1;
        end
    end
end