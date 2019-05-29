filename = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';
          '*.*','All Files' },'Choose first picture', '../input/');
filename2 = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';
          '*.*','All Files' },'Choose second picture', '../input/');
%read 2 images
A=imread(['../input/' filename]);
B=imread(['../input/' filename2]);

%select feature-points, third parameter is the number of points to select
[ xA, yA, xB, yB ] = getFeaturePos(A, B, 13);

%InterpolateGUI needs 2 images of the same size as arguments
InterpolateGUI(A, B, xA, yA, xB, yB);