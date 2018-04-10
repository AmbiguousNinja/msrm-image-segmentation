% TODO - description
function imageMarked = labelSets(image, h, w)
    imageMarked = zeros(h, w);
    
    g = zeros(1,1,3);
    b = zeros(1,1,3);
    
    g(:,:,:) = [0 255 0];   % Green
    b(:,:,:) = [0 0 255];   % Blue
    
    for (i = 1:h)
        for (j = 1:w)
            if image(i, j, :) == g
                imageMarked(i, j) = 2;
            elseif (image(i, j, :) == b)
                imageMarked(i, j) = 1;
            end
        end
    end
end