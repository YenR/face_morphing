function [ xA, yA, xB, yB ] = getFeaturePos( A, B, n )
%getFeaturePos 
%get the position of the left and right eye and the mouth for each of the
%two input pictures A and B.
%   Returns four 3D vectors xA, yA, xB and yB. Each vector contains the X
%   or the Y coordinates of the three features for the respective image A
%   or B.

f1 = figure('Name', ['Choose ' num2str(n) ' important points in the picture!'],'NumberTitle','off');
movegui(f1, [200, -200]);
imshow(A); axis equal, axis off; hold on;
[xA,yA]=myginput(n);   % select n features
hold on;
plot(xA,yA,'m.',xA,yA,'yo');

f2 = figure('Name', ['Choose ' num2str(n) ' important points in the picture!'],'NumberTitle','off');
movegui(f2, [-200, -200]);
imshow(B); axis equal, axis off; hold on;
[xB,yB]=myginput(n);   % select n features
hold on;
plot(xB,yB,'m.',xB,yB,'yo');

close all;

end

