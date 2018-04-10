% TODO - description
function regions = createRegions(imageRegions, quantizedImage, imageMarked, h, w, regionCount)
    binCount = max(quantizedImage(:));
    
    % Initialize Regions
    for (rgnIdx = 1:regionCount)
        regions(rgnIdx).area = 0;
        regions(rgnIdx).type = 0;    % 0: non-marked (N), 1: background (Mb), 2: object (Mo)
        regions(rgnIdx).hist = zeros(binCount, 1);
        
        regions(rgnIdx).stat = 0';
    end
    
    % Populate Regions
    for (i = 1:h)
       for (j = 1:w)
           rgnIdx = imageRegions(i, j);
           bin    = quantizedImage(i, j);
           
           regions(rgnIdx).hist(bin) = regions(rgnIdx).hist(bin) + 1;
           regions(rgnIdx).area = regions(rgnIdx).area + 1;
           regions(rgnIdx).type = max(regions(rgnIdx).type, imageMarked(i, j));
       end
    end
end