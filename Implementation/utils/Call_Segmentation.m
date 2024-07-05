function SegmentedData = Call_Segmentation(X,DenoisedData,Iteration,Morph)

[~,~,BW2] = Active_Retina(X,DenoisedData,Iteration,Morph);
SegmentedData = BW2;
% [maskedImage,BW1,BW2] = ...

