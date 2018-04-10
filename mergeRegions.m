% Merges regions marked for merging and removes merged regions
function [newImageRegions, cnt, newRegions] = mergeRegions(imageRegions, regionCount, regions)
    newImageRegions = zeros(size(imageRegions));
    
    cnt = 0;
    
    for (i = 1:regionCount)
        if regions(i).stat <= 0
            cnt = cnt + 1;
            
            % Replace all region i in imageRegions with the new region index
            idxs = find(imageRegions == i);
            newImageRegions(idxs) = cnt;
            
            % Transfer existing region information
            newRegions(cnt).hist = regions(i).hist;
            newRegions(cnt).type = regions(i).type;
            newRegions(cnt).area = regions(i).area;
            newRegions(cnt).stat = 0;
            
            % Merge marked regions
            if regions(i).stat < 0
                for j=1:regionCount
                    if regions(j).stat == i
                        idxs = find(imageRegions==j);
                        newImageRegions(idxs)=cnt;

                        newRegions(cnt).hist = newRegions(cnt).hist + regions(j).hist;
                        newRegions(cnt).type = max(newRegions(cnt).type, regions(j).type);
                        newRegions(cnt).area = newRegions(cnt).area + regions(j).area;
                    end
                end
            end
        end
    end
end