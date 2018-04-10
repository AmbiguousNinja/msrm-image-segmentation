 function [merged, adjMatrix, imageRegions, regionCount, regions] = mergingStage(adjMatrix, imageRegions, regionCount, regions, type)
    merged = 0;

    h = size(imageRegions, 1);
    w = size(imageRegions, 2);

    while 1
        flag = 0;
        
        for (i = 1:regionCount)
            if (regions(i).type == type)
                for (j = 1:regionCount)    
                    if (i == j || adjMatrix(i, j) == 0 || regions(j).type ~= 0)
                       continue
                    end
                   
                    [~, idx] = max(adjMatrix(j,:));

                    if i == idx
                        regions = markForMerging(i, j, regions, regionCount);
                        
                        flag = 1;
                        merged = 1;
                    end
                end
            end
        end
        
        if flag == 0
            break;
        end
        
        % Merging post processing
        [imageRegions, regionCount, regions] = mergeRegions(imageRegions, regionCount, regions);
        adjMatrix = createAdjacencyMatrix(imageRegions, regions, regionCount, h, w);
    end
end