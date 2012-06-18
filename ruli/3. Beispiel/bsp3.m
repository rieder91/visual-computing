%
% Thomas Rieder, 1125403
% 2012-06-17
%

% read input file
input = ~imread('bsp3-1.bmp');

% distance tranformation
distance = bwdist(input, 'chessboard');
distance = distance / max(max(distance));

% find blobs using dilate
blobs = distance < imdilate(distance, [1 1 1; 1 1 1; 1 1 1]);

% clean up borders; needed because of border-replication done by the
% dilation-function
blobs(1,:) = 1;
blobs(end,:) = 1;
blobs(:,1) = 1;
blobs(:,end) = 1;

% blending the blobs and the input together
%
% blobs = yellow
% input = green
% background = black
%
output1(:,:,1) = uint8(~blobs);
output1(:,:,2) = uint8(~blobs);
output1(:,:,3) = uint8(input);
output1 = 255 * output1;


% skeletize image
%
% i assumed that the previously created blob image needed to be skeletized
% as this made the most sense to me; "we want a skeleton of all areas of
% the image with the same distance"; if this assumption was wrong, the
% blobs variable just needs to be replaced with "input"
%

% close the blobs to create a more consistent skeleton
output2 = imclose(~blobs, [1 1 1; 1 1 1; 1 1 1]);
output2 = bwmorph(output2, 'skel', inf);

% write output
imwrite(output1, 'bsp3-2.bmp');
imwrite(output2, 'bsp3-3.bmp');

