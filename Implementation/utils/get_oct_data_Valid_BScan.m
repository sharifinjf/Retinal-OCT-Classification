function X = get_oct_data_Valid_BScan(iter_case,iter_B_Scan)
addpath('data_valid')

temp = load(['Case (' num2str(iter_case) ').mat']);
tf3 = isfield(temp, 'd3');
tf5 = isfield(temp, 'd5');

if tf3 ==1
    tempvar = getfield(temp, 'd3');
    X = tempvar(:,:,iter_B_Scan);
elseif tf5 == 1
    tempvar = getfield(temp, 'd5');
    X = tempvar(:,:,iter_B_Scan);
end

% display('Data Loading is finished ...')
rmpath('data_valid')
