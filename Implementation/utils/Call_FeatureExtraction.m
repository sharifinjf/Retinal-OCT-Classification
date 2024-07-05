function FeatureVector = Call_FeatureExtraction(img,Feature)

addpath utils

switch Feature
    case 'HOG'
        cell_size = [8 8]; % size of each cell pixel
        BlockSize = [4 4];
        BlockOverlap=[2 2];
        NumBins = 9;
        %                 FeatureVector    = HOG(img{iter_case,1}(:,:,iter_B_Scan));
        FeatureVector    = extractHOGFeatures(img,...
            'CellSize', cell_size, 'BlockSize', BlockSize, 'BlockOverlap', BlockOverlap, 'NumBins', NumBins );
        
    case 'distance'        
        FeatureVector    = Mydistance(img);
        
        
        %     case 'LBP'
        %         LbpPar           = 5;
        %         FeatureVector    = FnLBPFeatureExtractor(img, LbpPar);
        %     case 'POEM'
        %         No_orientations  = 4;  % number of discritize levels for phase of gradient image
        %         cell_size        = 9;  % size of each cell pixel
        %         L                = 14; % diameter of the block for calculation of binary code in LBP
        %         thr              = 0;  % threshold value for calculation of binary code in LBP
        %         No_neighbors     = 8;  % number of neighbors for calculation of binary code in LBP
        %         No_Patch         = 6;  % number of patches for which the histograms will be computed e.g. 6*6 patches
        %         FeatureVector    = FnPoemFeatureExtractor(img, No_orientations, cell_size, No_neighbors, L, thr, No_Patch);
end

