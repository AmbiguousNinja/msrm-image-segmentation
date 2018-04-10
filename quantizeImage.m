% Uniformly quantize into 4096 colours
function imageQuantized = quantizeImage(image, h, w)
    image = double(image);
    imageQuantized = size(h, w);
    
    bin = 256/16;   % 16*16*16 = 4096 bins
    
    for (i = 1:h)
        for (j = 1:w)
            r = floor(image(i, j, 1)/bin);
            g = floor(image(i, j, 2)/bin);
            b = floor(image(i, j, 3)/bin);

            % Uniform Quantization
            binNumber = r + bin*g + bin*bin*b;
            imageQuantized(i, j) = max(binNumber, 1);
        end
    end
end