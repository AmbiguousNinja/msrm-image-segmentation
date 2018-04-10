clear;
clc
close all;

%% Setup
image       = imread('test/bird.bmp');
imageSeg    = imread('test/bird_seg.png');
imageMarked = imread('test/bird_marked.png');

% image       = imread('test/mona.bmp');
% imageSeg    = imread('test/mona_seg.png');
% imageMarked = imread('test/mona_marked.png');

% image       = imread('test/woman.bmp');
% imageSeg    = imread('test/woman_seg.png');
% imageMarked = imread('test/woman_marked.png');

h = size(image, 1);
w = size(image, 2);

%% Image Preparation
imageRegions   = labelRegions(imageSeg, h, w);
imageMarked    = labelSets(imageMarked, h, w);
imageQuantized = quantizeImage(image, h, w);

%% Intialize Regions
regionCount = max(imageRegions(:));

regions   = createRegions(imageRegions, imageQuantized, imageMarked, h, w, regionCount);
adjMatrix = createAdjacencyMatrix(imageRegions, regions, regionCount, h, w);

%% Merging
while 1
    merged = 0;
    
    %% Stage 1
    while 1
        [regions, marked] = markRegions(adjMatrix, regions, regionCount, 1);
        
        if marked == 0
            break;
        else
            merged = 1;
        end
        
        % Merge Regions
        [imageRegions, regionCount, regions] = mergeRegions(imageRegions, regionCount, regions);
        adjMatrix = createAdjacencyMatrix(imageRegions, regions, regionCount, h, w);
    end
    
    %% Stage 2
    while 1
        [regions, marked] = markRegions(adjMatrix, regions, regionCount, 0);
        
        if marked == 0
            break;
        else
            merged = 1;
        end
        
        % Merging marked regions
        [imageRegions, regionCount, regions] = mergeRegions(imageRegions, regionCount, regions);
        adjMatrix = createAdjacencyMatrix(imageRegions, regions, regionCount, h, w);
    end
    
    % Exit Condition
    if (merged == 0)
        break;
    end
end

%% Extract the object
extractionMask = zeros(size(imageRegions));

for (i = 1:regionCount)
    if regions(i).type ~= 1
        extractionMask(find(imageRegions == i)) = 1;
    end
end

idxs = find(extractionMask == 0);

for (i = 1:3)
    tmp = image(:, :, i);
    tmp(idxs) = 255;
    image(:, :, i) = tmp;
end

% imshow(image)