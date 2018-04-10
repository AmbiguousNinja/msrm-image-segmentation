clear;
clc
close all;

%% Setup
image       = imread('bird.bmp');
imageSeg    = imread('bird_seg.png');
imageMarked = imread('bird_marked2.png');
% image       = imread('goose.png');
% imageSeg    = imread('goose_seg.png');
% imageMarked = imread('goose_marked.png');

imageH = size(image, 1);
imageW = size(image, 2);

%% Image Preparation
imageRegions   = labelRegions(imageSeg, imageH, imageW);
imageMarked    = labelSets(imageMarked, imageH, imageW);
imageQuantized = quantizeImage(image, imageH, imageW);

imshow(drawSegments(image, imageRegions,imageH, imageW));
% waitforbuttonpress
% imwrite(drawSegments(image, imageRegions), 'output/segmentedImage.png');

%% Intialize Regions
regionCount = max(imageRegions(:));

regions   = createRegions(imageRegions, imageQuantized, imageMarked, imageH, imageW, regionCount);
adjMatrix = createAdjacencyMatrix(imageRegions, regions, regionCount, imageH, imageW);
mergeTable = -1 * ones(1, regionCount);     % TODO - reimplement

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

imageExtracted = drawSegments(image, imageResult, imageH, imageW);
% imwrite(imageExtracted, 'output/imageExtracted.png');
imshow(imageExtracted)