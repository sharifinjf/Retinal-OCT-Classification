


clc; clear; close all;
addpath utils
dbstop if error


Number_Case = 30;      % Total number of Patients in the dataset used for this demo
Number_B_Scan = 128;   % Spectral dimension of the image
Feature = 'HOG';       % Three types of feature extraction: 'LBP', 'HOG', 'POEM'
                       % Currently, HOG is working!                      
BScanLables = xlsread('Bscan_labels.csv');
BScanLables = BScanLables';
load(['FeatureVector_' num2str(Feature) '.mat'])


% length of feature vector for each B Scan
length_FV = length(FeatureVector{1,1})/Number_B_Scan; 
%==========================================================================
% Train data: 3840*174096
%             3840 = 128*30
%             174096 = length of feature vector for each B Scan
Data_train  = zeros(Number_B_Scan*Number_Case,length_FV);
Lable_train = zeros(Number_B_Scan*Number_Case,1);

count = 1;
for itr_case = 1:Number_Case
    for itr_BScan = 1:Number_B_Scan
        Data_train(count,:) = FeatureVector{itr_case,1}((itr_BScan-1)*length_FV+1:(itr_BScan)*length_FV);
        Lable_train(count)  = BScanLables(itr_case,itr_BScan);
        count = count + 1;
    end
end

%==================================
load(['FeatureVector_Valid_' num2str(Feature) '.mat'])
% FeatureVector_Valid
% Validation data: 1280*174096
%                  1280 = 128*10
Number_Valid = 10;
Data_valid  = zeros(Number_B_Scan*Number_Valid,length_FV);
% Lable_valid = zeros(Number_B_Scan*Number_Valid,1);

count_valid = 1;
for itr_case = 1:Number_Valid
    for itr_BScan = 1:Number_B_Scan
        Data_valid(count_valid,:) = FeatureVector_Valid{itr_case,1}((itr_BScan-1)*length_FV+1:(itr_BScan)*length_FV);
%         Lable_valid(count_valid)  = BScanLables_Valid(itr_case,itr_BScan);
        count_valid = count_valid + 1;
    end
end

%% Classification:
% SVM
[label_predicted_Valid,score_Valid] = Call_SVM_Valid(Data_train,Data_valid,Lable_train);

%============== Predicted labels vector into matrix
label_predicted_Valid_mat = zeros(Number_B_Scan,Number_Valid);

count = 1;
for itr_case = 1:Number_Valid
    for itr_BScan = 1:Number_B_Scan
        label_predicted_Valid_mat(itr_BScan,itr_case) = label_predicted_Valid(count);
        count = count + 1;
    end
end
%=========================================
save label_predicted_Valid_mat.mat label_predicted_Valid_mat

Sensitivity   = zeros(Number_Valid,1);
for itr = 1:Number_Valid
    Label_case  = BScanLables_Valid(:,itr);
    isLabels_case  = [0;1];
    [ConfMat_test,~,accuracy,precision,recall] = confusion_matrix(Label_case,label_predicted_Valid_mat(:,itr),isLabels_case);  title('SVM')
    Sensitivity(itr) = ConfMat_test(1,1);
end

Sensitivity

% % KNN
% K = 5;
% Call_KNN(Feature,K,Data_train,Data_test,Lable_train,Lable_test)
% 
% % Neural Network
% %Call_NN(Feature,Data_train,Data_test,Lable_train,Lable_test)






