% Label each region with a unique ID
function imageRegions = labelRegions(imgSeg, h, w)
    binImg  = imbinarize(imgSeg(:,:,1));
    temp    = bwlabel(binImg);

    imageRegions = temp;
 
    % Populate 0s with neighboring value
    while (isempty(find(imageRegions == 0, 1)) == 0)
        for (i = 1:h)
            for (j = 1:w)
                if (temp(i, j) == 0)
                    for (k = -1:1)
                        for (l = -1:1)
                            row = i+k;
                            col = j+l;
                            
                            if (col >= 1 && col <= w && row >= 1 && row <= h)
                                if (temp(row, col) ~= 0)
                                    imageRegions(i, j) = temp(row, col);
                                end
                            end
                        end
                    end
                end
            end
        end
        
        temp = imageRegions;
    end
end