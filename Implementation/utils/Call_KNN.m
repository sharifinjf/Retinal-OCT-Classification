function Call_KNN(Feature,K,X_train,X_test,Y_train,Y_test)

% train
isLabels_train    = unique(Y_train);
tabulate(categorical(Y_train));
isLabels_test     = unique(Y_test);

Class             = knnclassify(X_test, X_train,Y_train,K);
% a                 = 1:length(Class);
% FalseInd          = a(~strcmp(Y_test,Class));
% FalseImg          = FN(FalseInd);
[ConfMat_test,~,accuracy,precision,recall] = confusion_matrix(Y_test,Class,isLabels_test); title('KNN')
T_test            = [num2cell(isLabels_test) num2cell(ConfMat_test)];
T_test            = [[' ' num2cell(isLabels_test)'];T_test];
xlswrite(['Confmat_KNN_' Feature '_K_' num2str(K)],T_test)
% xlswrite(['FalseImg_KNN_' Feature '_K_' num2str(K)],FalseImg)
save(['Metrics_KNN_' Feature '_K_' num2str(K)],'accuracy','precision','recall')