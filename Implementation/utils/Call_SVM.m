function [label_predicted,score] = Call_SVM(Feature,X_train,X_test,Y_train,Y_test)

isLabels_train    = unique(Y_train);
tabulate(categorical(Y_train));
isLabels_test     = unique(Y_test);

t                 = templateSVM('Standardize',1);
% options             = statset('UseParallel',1);
Mdl               = fitcecoc(X_train,Y_train,'Coding','onevsall','Learners',t,'Prior','uniform');%,'Options',options); % 'Prior','empirical'

Data_all        = [X_train;X_test];
[label_predicted,score] = predict(Mdl,Data_all);



