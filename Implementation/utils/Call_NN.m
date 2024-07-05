function Call_NN(Feature,X_train,X_test,Y_train,Y_test)
% train
isLabels_train             = unique(Y_train);
tabulate(categorical(Y_train));
x_train                    = X_train';
y_train                    = zeros(size(Y_train));
temp_train                 = unique(Y_train);
for i=1:length(temp_train)
    y_train(strcmp(temp_train(i),Y_train)) = i;
end
cl_train                   = max(y_train);
N_train                    = size(X_train,1);
t_train                    = -1*ones(N_train,cl_train);
for qt = 1:N_train
    t_train(qt,y_train(qt,1)) = 1;
end
t_train                    = t_train';
% test
isLabels_test              = unique(Y_test);
tabulate(categorical(Y_test));
x_test                     = X_test';
y_test                     = zeros(size(Y_test));
temp_test                  = unique(Y_test);
for i=1:length(temp_test)
    y_test(strcmp(temp_test(i),Y_test)) = i;
end
cl_test                    = max(y_test);
N_test                     = size(X_test,1);
t_test                     = -1*ones(N_test,cl_test);
for qt = 1:N_test
    t_test(qt,y_test(qt,1))= 1;
end
t_test                     = t_test';
% network
trainFcn                   = 'trainscg';  
hiddenLayerSize            = [100 200 100];
net                        = fitnet(hiddenLayerSize,trainFcn);
net.input.processFcns      = {'removeconstantrows','mapminmax'};
net.output.processFcns     = {'removeconstantrows','mapminmax'};
net.divideFcn              = 'dividerand';  % Divide data randomly
net.divideMode             = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 90/100;
net.divideParam.valRatio   = 10/100;
net.divideParam.testRatio  = 0/100;
net.performFcn             = 'mse';  % Mean Squared Error
net.plotFcns               = {'plotperform','plottrainstate','ploterrhist','plotregression'};
[net,tr]                   = train(net,x_train,t_train);%,'useGPU','yes');
y_train                    = net(x_train);
y_test                     = net(x_test);
e                          = gsubtract(t_train,y_train);
performance                = perform(net,t_train,y_train);
trainTargets               = t_train .* tr.trainMask{1};
valTargets                 = t_train .* tr.valMask{1};
testTargets                = t_train .* tr.testMask{1};
trainPerformance           = perform(net,trainTargets,y_train);
valPerformance             = perform(net,valTargets,y_train);
% testPerformance            = perform(net,x_test,y_test);
view(net)
% Plots
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, ploterrhist(e)
% figure, plotregression(t,y)
a                          = 1:length(y_test);
FalseInd                   = a(~strcmp(t_test,y_test));
FalseImg                   = FN(FalseInd);
[~,ll1_test]               = max(t_test);
[~,ll2_test]               = max(y_test);
[ConfMat_test,~]           = confusion_matrix(ll1_test,ll2_test,temp_test); title('Test')
T_test                     = [temp_test num2cell(ConfMat_test)];
T_test                     = [[' ' temp_test'];T_test];
xlswrite(['Confmat_NN_Test_' Feature],T_test)

[~,ll1_train]              = max(t_train);
[~,ll2_train]              = max(y_train);
[ConfMat_train,~,accuracy,precision,recall] = confusion_matrix(ll1_train,ll2_train,temp_train'); title('Train')
T_train                    = [temp_train num2cell(ConfMat_train)];
T_train                    = [[' ' temp_train'];T_train];
xlswrite(['Confmat_NN_Train_' Feature],T_train)
xlswrite(['FalseImg_NN_' Feature],FalseImg)
save(['Metrics_NN_' Feature],'accuracy','precision','recall')