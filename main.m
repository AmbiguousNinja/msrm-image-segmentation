clear;
clc
close all;

%% Setup
image       = imread('bird.bmp');
imageSeg    = imread('bird_seg.png');
imageMarked = imread('bird_marked2.png');

h = size(image, 1);
w = size(image, 2);

%% Image Preparation
imageRegions   = labelRegions(imageSeg, h, w);
imageMarked    = labelSets(imageMarked, h, w);
imageQuantized = quantizeImage(image, h, w);

% imwrite(drawSegments(image, imageRegions,h, w), 'output/segmentedImage.png');

%% Intialize Regions
regionCount = max(imageRegions(:));

regions   = createRegions(imageRegions, imageQuantized, imageMarked, h, w, regionCount);
adjMatrix = createAdjacencyMatrix(imageRegions, regions, regionCount, h, w);

%% Merging
while 1
    % Stage 1
    [merged, adjMatrix, imageRegions, regionCount, regions] = mergingStage(adjMatrix, imageRegions, regionCount, regions, 1);
    
    % Stage 2
    [merged, adjMatrix, imageRegions, regionCount, regions] = mergingStage(adjMatrix, imageRegions, regionCount, regions, 0);
    
    % Exit Condition
    if (merged == 0)
        break;
    end
end

%% Extract the object
imageResult = zeros(size(imageRegions));

for (i=1:regionCount)
    if regions(i).type ~= 1
        imageResult(find(imageRegions==i))=1;
    end
end
% imwrite(imageResult, 'output/imageMask.png');
imageExtracted = drawSegments(image, imageResult, h, w);
% imwrite(imageExtracted, 'output/imageExtracted.png');
imshow(imageExtracted)