%function [ x, y ] = detectEyes(A)

    filename = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';
       '*.*','All Files' },'Choose first picture', '../input/');

    A = imread(['../input/' filename]);
    W_unscaled = imread('weighting.png');
    W = imresize(W_unscaled,[size(A,1) size(A,2)]);

    % windowSize....size for the neighborhood of the analyzing function
    %               percentage of image size, initially 10% horiz. and 3.3%
    %               vert. These proved to be too large.
    % threshold.....minimum level of frequency
    % edit these to tweak detection rate
    windowSizeX=0.015;
    windowSizeY=0.015;
    threshold=0.9;

    % neighbourhood needs odd dimensions
    wsx=2*floor(windowSizeX*size(A,2)/2)+1;
    wsy=2*floor(windowSizeY*size(A,1)/2)+1;
    NHOOD=ones(wsy, wsx);

    % evaluated multiple methods, rangefilter was the most successful
    %method='std';
    %method='ent';
    method='rng';

    % only luminance is needed
    gray_I = double(rgb2gray(A));
    gray_W = double(rgb2gray(W));

    % normalize
    norm_I = (gray_I - min(gray_I(:)))./(max(gray_I(:)) - min(gray_I(:)));
    norm_W = (gray_W - min(gray_W(:)))./(max(gray_W(:)) - min(gray_W(:)));


    switch method
        case 'std'
            A = stdfilt(norm_I,NHOOD);
        case 'ent'
            A = entropyfilt(norm_I,NHOOD);
        case 'rng'
            A = rangefilt(norm_I,NHOOD);
    end

    % take the a priori weighting into account
    weigthed_A=(A+norm_W)/2;

    % DEBUG
    figure, imshow (A);
    %figure, imshow(weigthed_A);
    D = im2bw(weigthed_A,threshold);
    % DEBUG
    %figure, imshow(D);
    hold on;
    
    STATS=regionprops(D,'Centroid');
    centroids = cat(1, STATS.Centroid);
    % DEBUG
    plot(centroids(:,1), centroids(:,2), 'b*')
    x=centroids(:,1);
    y=centroids(:,2);
%end