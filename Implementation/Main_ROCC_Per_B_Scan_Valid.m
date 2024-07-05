% In the name of ALLAH


% Written by DiSPLaY Group for MVIP ROCC Grand Challenge
% Shahid Beheshti University, Tehran, Iran
% Last update: 2017/11/03

clc; clear; close all;
addpath utils

params_data.K  = 2;     % number of classes, Healthy and Patient
params_data.Nx = 512;   % X dimension of the image
params_data.Ny = 650;   % Y dimension of the image
Number_Valid   = 10;    % Total number of Patients in the dataset used for this demo
Number_B_Scan  = 128;   % Spectral dimension of the image
Feature = 'HOG';        % Three types of feature extraction: 'LBP', 'HOG', 'POEM'
                        % Currently, HOG is working!
                       
tic;
FeatureVector_Valid = cell(Number_Valid,1);
for iter_case = 1:Number_Valid
    for iter_B_Scan = 1: Number_B_Scan
        display(['case number ' num2str(iter_case) ' Bscan ' num2str(iter_B_Scan)])
        % -----------------------------------------------------------------
        % Reading the data:
        % -----------------------------------------------------------------
        params_data.X = get_oct_data_Valid_BScan(iter_case,iter_B_Scan);
        % -----------------------------------------------------------------
        % Denoising using Wavelet and 3 times median filter
        % -----------------------------------------------------------------
        DenoisedData = Call_Denoising(params_data.X);
        % -----------------------------------------------------------------
        % Segmentation using Active Contour
        % -----------------------------------------------------------------
        Iteration = 500;
        Morph = 1;
        SegmentedData = Call_Segmentation(params_data.X,DenoisedData,Iteration,Morph);
        % -----------------------------------------------------------------
        % Feature Extraction
        % -----------------------------------------------------------------
        temp = Call_FeatureExtraction(SegmentedData,Feature);
        FeatureVector_Valid{iter_case,1}((iter_B_Scan-1)*length(temp)+1:(iter_B_Scan)*length(temp)) = temp;
        
    end
end
Total_Time = toc;
save(['FeatureVector_Valid_' num2str(Feature) '.mat'], 'FeatureVector_Valid','Total_Time','-v7.3')

% each cell of FeatureVector is features of one case (we have 30 cases)
% we have stacked HOG features of all B Scans in a row vector
% The number of features for each B scan is: 
% Finally, 128 * 174096 = 22284288 is the size of each row vector.

