function X = get_oct_data_BScan(iter_case,iter_B_Scan)
addpath('data')

load(['Case (' num2str(iter_case) ').mat']);
if iter_case <=15
    X = d3(:,:,iter_B_Scan);
elseif iter_case > 15
    X = d5(:,:,iter_B_Scan);
    
end

% display('Data Loading is finished ...')
rmpath('data')
