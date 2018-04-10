function [newImageRegions, newRegionCount, newRegions] = mergeRegions(imageRegions, regionCount, regions)
    newImageRegions = zeros(size(imageRegions));
    
    k = 0;
    
    for (i = 1:regionCount)
        if regions(i).stat == 0
            k = k+1;
            ind = find(imageRegions==i);   % Replace all region i in Label (I) with the new region counter, k
            newImageRegions(ind)=k;

            newRegions(k).hist = regions(i).hist;
            newRegions(k).type = regions(i).type;
            newRegions(k).area = regions(i).area;
            
            newRegions(k).stat = 0;
        elseif regions(i).stat == -1
            k=k+1;
            ind=find(imageRegions==i);
            newImageRegions(ind)=k;

            newRegions(k).hist = regions(i).hist;
            newRegions(k).type = regions(i).type;
            newRegions(k).area = regions(i).area;
            newRegions(k).stat = 0;
            
            for j=1:regionCount
                % Merge the regions
                if regions(j).stat == i
                    ind = find(imageRegions==j);
                    newImageRegions(ind)=k;

                    newRegions(k).hist = newRegions(k).hist + regions(j).hist;
                    newRegions(k).type = max(newRegions(k).type, regions(j).type);
                    newRegions(k).area = newRegions(k).area + regions(j).area;
                end
            end
        end        
    end
    
    newRegionCount = k;
end