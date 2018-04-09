clear;
clc
close all;

%% Load Image
imagePath    = 'bird.bmp';
imageSegPath = 'bird_seg.png';

image    = imread(imagePath);
imageSeg = imread(imageSegPath);

