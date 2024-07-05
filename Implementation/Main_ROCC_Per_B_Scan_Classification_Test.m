clc; clear; close all;
addpath utils
dbstop if error


Number_Case = 30;      % Total number of Patients in the dataset used for this demo
Number_B_Scan = 128;   % Spectral dimension of the image
Feature = 'HOG';       % Three types of feature extraction: 'LBP', 'HOG', 'POEM'
                       % Currently, HOG is working!                      
%==================================
load(['FeatureVector_Test_' num2str(Feature) '.mat'])
% FeatureVector_Test
% Validation data: ???*174096
%                  ??? = 128*??
Number_Test = 30;
% length of feature vector for each B Scan
length_FV = length(FeatureVector_Test{1,1})/Number_B_Scan; 
Data_Test  = zeros(Number_B_Scan*Number_Test,length_FV);
% Lable_valid = zeros(Number_B_Scan*Number_Valid,1);

count_Test = 1;
for itr_case = 1:Number_Test
    for itr_BScan = 1:Number_B_Scan
        Data_Test(count_Test,:) = FeatureVector_Test{itr_case,1}((itr_BScan-1)*length_FV+1:(itr_BScan)*length_FV);
        count_Test = count_Test + 1;
    end
end

%% Classification:
% SVM
load('SVM_Classifier_Train30.mat')
[label_predicted_Test,score] = predict(Mdl,Data_Test);

%============== Predicted labels vector into matrix
label_predicted_Test_mat = zeros(Number_B_Scan,Number_Test);

count = 1;
for itr_case = 1:Number_Test
    for itr_BScan = 1:Number_B_Scan
        label_predicted_Test_mat(itr_BScan,itr_case) = label_predicted_Test(count);
        count = count + 1;
    end
end
%=========================================
save label_predicted_Test_mat.mat label_predicted_Test_mat

% Sensitivity   = zeros(Number_Test,1);
% for itr = 1:Number_Test
%     Label_case  = BScanLables_Test(:,itr);
%     isLabels_case  = [0;1];
%     [ConfMat_test,~,accuracy,precision,recall] = confusion_matrix(Label_case,label_predicted_Test_mat(:,itr),isLabels_case);  title('SVM')
%     Sensitivity(itr) = ConfMat_test(1,1);
% end
% 
% Sensitivity



