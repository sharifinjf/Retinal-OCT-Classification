function X = get_oct_data_Test_BScan(iter_case,iter_B_Scan)
addpath('data_test1')

temp = load(['Case(' num2str(iter_case) ').mat']);
tf3 = isfield(temp, 'data');
%tf5 = isfield(temp, 'data');

%if tf3 ==1
    tempvar = getfield(temp, 'data');
    X = tempvar(:,:,iter_B_Scan);
%elseif tf5 == 1
% %     tempvar = getfield(temp, 'data');
% %     X = tempvar(:,:,iter_B_Scan);
%end

% display('Data Loading is finished ...')
rmpath('data_test1')
