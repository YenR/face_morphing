function [ out ] = ownImresize( in, outSize )
%OWNIMRESIZE Summary of this function goes here
%   Detailed explanation goes here
    if (length(size(in)) == 3)
        outSize(3) = size(in,3);
    end
    if outSize(2) ~= size(in,2)
        out1 = zeros(size(in,1),outSize(2),outSize(3));
        step = (size(in,2)-1)/(outSize(2)-1);
        posIndex = 1;
        for x = 1:outSize(2)-1
            index1 = floor(posIndex);
            index2 = index1 + 1;
            factor2 = mod(posIndex,1);
            factor1 = 1 - factor2;
            out1(:,x,:) = in(:,index1,:) * factor1 + in(:,index2,:) * factor2;
            posIndex = posIndex + step;
        end
        out1(:,end,:) = in(:,end,:);
    else
        out1 = in;
    end
    
    if outSize(1) ~= size(in,1)
        out = zeros(outSize);
        step = (size(in,1)-1)/(outSize(1)-1);
        posIndex = 1;
        for y = 1:outSize(1)-1
            index1 = floor(posIndex);
            index2 = index1 + 1;
            factor2 = mod(posIndex,1);
            factor1 = 1 - factor2;
            out(y,:,:) = out1(index1,:,:) * factor1 + out1(index2,:,:) * factor2;
            posIndex = posIndex + step;
        end
        out(end,:,:) = out1(end,:,:);
    else
        out = out1;
    end
end

