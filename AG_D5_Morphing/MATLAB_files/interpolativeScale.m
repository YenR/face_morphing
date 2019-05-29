function [ outImg ] = interpolativeScale( img, coordsOriginal, coordsMoved, interpolationVal, dim )
%INTERPOLATESCALE Summary of this function goes here
%   Detailed explanation goes here
    img = im2double(img);
    outImg =zeros(size(img));
    % Punkte nach dim sortieren
    [~,sortIndexes] = sort(coordsOriginal(:,dim));
    sortedCoordsOriginal = zeros(size(coordsOriginal));
    for i=1:length(sortIndexes)
        sortedCoordsOriginal(i,:) = coordsOriginal(sortIndexes(i),:);
    end
    coordsOriginal = sortedCoordsOriginal;
    clear sortedCoordsOriginal;
    sortedCoordsMoved = zeros(size(coordsMoved));
    for i=1:length(sortIndexes)
        sortedCoordsMoved(i,:) = coordsMoved(sortIndexes(i),:);
    end
    coordsMoved = sortedCoordsMoved;
    clear sortedCoordsMoved;
    
    % Punkte verschieben
    coordsOriginal(2:size(coordsOriginal,1)+1,:) = coordsOriginal;
    coordsMoved(2:size(coordsMoved,1)+1,:) = coordsMoved;
    
    % ersten punkt einfügen (1,1)
    coordsOriginal(1,:) = [1,1];
    coordsMoved(1,:) = [1,1];
    % letzten punkt einfügen (height, width)
    coordsOriginal(size(coordsOriginal,1)+1,:) = [size(img,1),size(img,2)];
    coordsMoved(size(coordsMoved,1)+1,:) = coordsOriginal(size(coordsOriginal,1),:);
    
%     % doppelte Werte entfernen
%     [~,uniqueIndexes] = unique(coordsOriginal(:,dim));
%     uniqueCoordsOriginal = zeros([length(uniqueIndexes),2]);
%     for i=1:length(uniqueIndexes)
%         uniqueCoordsOriginal(i,:) = coordsOriginal(uniqueIndexes(i),:);
%     end
%     coordsOriginal = uniqueCoordsOriginal;
%     clear uniqueCoordsOriginal;
%     uniqueCoordsMoved = zeros([length(uniqueIndexes),2]);
%     for i=1:length(uniqueIndexes)
%         uniqueCoordsMoved(i,:) = coordsMoved(uniqueIndexes(i),:);
%     end
%     coordsMoved = uniqueCoordsMoved;
%     clear uniqueCoordsMoved;

    % überkreuzende Koordinaten behandeln
    newMoved(1) = coordsMoved(1,dim);
    newOriginal(1) = coordsOriginal(1,dim);
    valCount(1) = 1;
    i = 2;
    for j = 2:size(coordsMoved,1)
        error = coordsMoved(j,dim) <= ((newMoved(i-1) / valCount(i-1)) - 2);
        if error
            i = i-1;
        elseif i > 2
            while (newMoved(i-1) / valCount(i-1)) <= ((newMoved(i-2) / valCount(i-2)) - 2)
                newMoved(i-2) = newMoved(i-2) + newMoved(i-1);
                newMoved(i-1) = 0;
                newOriginal(i-2) = newOriginal(i-2) + newOriginal(i-1);
                newOriginal(i-1) = 0;
                valCount(i-2) = valCount(i-2) + valCount(i-1);
                valCount(i-1) = 0;
                i = i-1;
            end
        end
        if length(valCount) < i
            valCount(i) = 1;
            newMoved(i) = coordsMoved(j,dim);
            newOriginal(i) = coordsOriginal(j,dim);
        else
            valCount(i) = valCount(i) + 1;
            newMoved(i) = newMoved(i) + coordsMoved(j,dim);
            newOriginal(i) = newOriginal(i) + coordsOriginal(j,dim);
        end
        i = i+1;
    end
    newMoved = round(newMoved ./ valCount);
    newOriginal = round(newOriginal ./ valCount);
    
    % Bild erstellen
    newCoordLower = 1;
    for i = 1:length(newOriginal)-1
        origCoordLower = newOriginal(i);
        origCoordHigher = newOriginal(i+1);
        if origCoordHigher == origCoordLower
            continue;
        end
        newCoordHigher = round(origCoordHigher + interpolationVal * (newMoved(i+1)-origCoordHigher));
        newSize = newCoordHigher - newCoordLower + 1;
        if newSize <= 0
            continue;
        end
        if dim == 1
            outImg(newCoordLower:newCoordHigher,:,:) = ownImresize(img(origCoordLower:origCoordHigher,:,:),[newSize, size(img,2)]);
        elseif dim == 2
            outImg(:,newCoordLower:newCoordHigher,:) = ownImresize(img(:,origCoordLower:origCoordHigher,:),[size(img,1), newSize]);
        end
        newCoordLower = newCoordHigher;
    end
    
end

