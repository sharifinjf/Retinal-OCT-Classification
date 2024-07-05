function [label_predicted,score] = Call_SVM_Valid(X_train,X_test,Y_train)

tabulate(categorical(Y_train));

t                 = templateSVM('Standardize',1);
% options             = statset('UseParallel',1);
Mdl               = fitcecoc(X_train,Y_train,'Coding','onevsall','Learners',t,'Prior','uniform');%,'Options',options); % 'Prior','empirical'

save('SVM_Classifier_TRain30.mat','Mdl','-v7.3')

[label_predicted,score] = predict(Mdl,X_test);



