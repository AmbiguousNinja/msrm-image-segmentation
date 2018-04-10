 function [merged, adjMatrix, imageRegions, regionCount, regions] = mergingStage(adjMatrix, imageRegions, regionCount, regions, type)
    merged = 0;
    
%     mergeTable = -1*ones(1, regionCount);
    
    imageH = size(imageRegions, 1);
    imageW = size(imageRegions, 2);

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
%                         mergeTable = MergeRecord(mergeTable, i, j,regionCount);

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
%         [imageRegions, regionCount, regions] = MergePostProc2(imageRegions, mergeTable, regionCount, regions);
        [imageRegions, regionCount, regions] = mergeRegions(imageRegions, regionCount, regions);
        adjMatrix = createAdjacencyMatrix(imageRegions, regions, regionCount, imageH, imageW);
%         mergeTable = -1*ones(1, regionCount);
    end
end