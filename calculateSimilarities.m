function adjMatrix = calculateSimilarities(adjMatrix, regions)
    [i, j, ~] = find(adjMatrix);
    
    % For neighboring regions, calculate the similarity
    for k = (1:size(i, 1))
        rgn1 = i(k);
        rgn2 = j(k);
        
        h1 = sqrt(regions(rgn1).hist/regions(rgn1).area);
        h2 = sqrt(regions(rgn2).hist/regions(rgn2).area);
        
        adjMatrix(rgn1, rgn2) = h1' * h2;   % Bhattacharrya coefficient
    end
end