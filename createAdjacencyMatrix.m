% TODO - description
function adjMatrix = createAdjacencyMatrix(imageRegions, regions, regionCount, h, w)
    adjMatrix = zeros(regionCount, regionCount);
    
    for (i = 1:h)
        for (j = 1:w)
            idx = imageRegions(i, j);
            
            for (k = -1:1)
                for (l = -1:1)
                    row = i+k;
                    col = j+l;
                    
                    % If adjacent pixel is a different region, mark as adjacent!
                    if (row > 0 && row <= h && col > 0 && col <= w)
                        if (idx ~= imageRegions(row, col))
                            adjMatrix(idx, imageRegions(row, col)) = 1;
                        end
                    end
                end
            end
        end
    end
    
    % For neighboring regions, calculate the similarity
    for (i = 1:regionCount)
        for (j = 1:regionCount)
            if (i~=j && adjMatrix(i,j) > 0)
                h1 = sqrt(regions(i).hist/regions(i).area);
                h2 = sqrt(regions(j).hist/regions(j).area);
                
                adjMatrix(i, j) = h1'*h2;
            end
        end
    end
end