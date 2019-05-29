function [newImage] = interpolateImages (A, B, p)
newImage = (1-p) * A + p * B;
end