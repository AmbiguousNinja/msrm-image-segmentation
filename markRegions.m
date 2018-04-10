% Mark regions for merging
function [regions, marked] = markRegions(adjMatrix, regions, regionCount, regionType)
    marked = 0;
    
    for (i = 1:regionCount)
        if (regions(i).type == regionType)
            for (j = 1:regionCount)    
                if (i == j || adjMatrix(i, j) == 0 || regions(j).type ~= 0)
                   continue
                end

                [~, idx] = max(adjMatrix(j,:));

                if i == idx
                    regions = mark(i, j, regions, regionCount);
                    marked = 1;
                end
            end
        end
    end
end