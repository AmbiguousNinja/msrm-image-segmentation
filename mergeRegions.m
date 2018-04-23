% Merges regions marked for merging
function [newImageRegions, cnt, newRegions] = mergeRegions(imageRegions, regionCount, regions)
    newImageRegions = zeros(size(imageRegions));
    
    cnt = 0;
    
    for (i = 1:regionCount)
        
        currentRegion = regions(i);
        
        % Regions that do not have a 'stat' field <= 0 are regions that will be merged.
        if currentRegion.stat <= 0
            cnt = cnt + 1;
            
            % Replace all region i in imageRegions with the new region index
            idxs = find(imageRegions == i);
            newImageRegions(idxs) = cnt;
            
            % Transfer existing region information
            newRegions(cnt).hist = currentRegion.hist;
            newRegions(cnt).type = currentRegion.type;
            newRegions(cnt).area = currentRegion.area;
            
            % Reset merge flag to "unmerged"
            newRegions(cnt).stat = 0;
            
            % Merge marked regions
            if currentRegion.stat < 0  % If current region is a base for merging
                for (j = i:regionCount)
                    if regions(j).stat == i
                        idxs = find(imageRegions == j);
                        newImageRegions(idxs) = cnt;

                        newRegions(cnt).hist  = newRegions(cnt).hist + regions(j).hist;
                        newRegions(cnt).type  = max(newRegions(cnt).type, regions(j).type);
                        newRegions(cnt).area  = newRegions(cnt).area + regions(j).area;
                    end
                end
            end
        end
    end
end