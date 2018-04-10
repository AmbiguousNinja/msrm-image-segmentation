function image = drawSegments(image, imageRegions, h, w)
    for (i = 1:w)
        for (j = 1:h)
            for (k = -1:1)
                for (l = -1:1)
                    col = i+k;
                    row = j+l;

                    if (col >= 1 && col <= w && row >= 1 && row <= h)
                        if (imageRegions(j, i) < imageRegions(row, col))
                            image(j, i, :) = 255;
                        end
                    end
                end
            end
        end
    end
end