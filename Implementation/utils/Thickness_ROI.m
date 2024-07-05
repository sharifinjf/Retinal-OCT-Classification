function [ROI,Thick] = Thickness_ROI(BW)

% Finde Region Of Intrest from binary mask of OCT
% and Compute Thickness of ROI

% BW = Binary mask of OCT
% ROI = Region Of Intrest from BW (ROI=CL+OSL+VM+PRE = LAYER 8,9,10,12
%       In PRE.png picture)
% Thick = Thickness of ROI

se_c = strel('disk',5);
BW2 = imclose(BW,se_c);
BW2(1:end,1:5)=1;
BW2(1:end,end-4:end)=1;
BW2(1:5,1:end)=1;
BW2(end-4:end,1:end)=1;
BW3 = ~BW2;

CC1 = bwconncomp(BW3);
numPixels1 = cellfun(@numel,CC1.PixelIdxList);
[~,idx1] = max(numPixels1);
if numel(idx1) == 0
    ROI = zeros(size(BW2,1),size(BW2,2));
    Thick = sum(ROI);
else
    
    BW3(CC1.PixelIdxList{idx1}) = 0;
    %
    CC2 = bwconncomp(BW3);
    numPixels2 = cellfun(@numel,CC2.PixelIdxList);
    [~,idx2] = max(numPixels2);
    BW3(CC2.PixelIdxList{idx2}) = 0;
    
    ROI = double(BW3)*255;
    Thick = sum(ROI);
    % Thick = (Thick-min(Thick))./(max(Thick)-min(Thick));
end
end