% Input :
% X = Orginal Image with noise
% Y = Image Afetr Dnoising
% Iteration = Number of Active Contour Iterations You want
% Morph = 0 or 1 // if you want to apply open mask Morph must be equale to 1

% Output :
% maskedImage = masked Image
% BW1 = Binary Image mask after active contour
% BW2 = Binary Image mask (if morh=1 BW2 is the mask after open mask)

function [maskedImage,BW1,BW2] = Active_Retina(X,Y,Iteration,Morph)

Y = 255*(Y./max(Y(:)));
%% Threshold image :
thresh = multithresh(Y,5);
% ss = imquantize(Y,thresh);
% RGB1 = ((label2rgb(ss)));
mask = Y>=thresh(2);

%% Active Contour
Iterations = Iteration;
% BW1 = activecontour(X,mask,Iterations);
BW1 = mask;
%% Open mask with disk
if Morph == 1
    radius = 1;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW2 = imopen(BW1, se);
else
    BW2 = BW1;
end

% Create masked image.
maskedImage = X;
maskedImage(~BW2) = 0;

end