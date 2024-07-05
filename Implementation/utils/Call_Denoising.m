% Image denoising using wavelet and median filter
%
% Input:
% Data_Noisy: Data before denoising
%
% Output:
% DenoisedData: Data after denoising
%
% Prepared by Aliasghar Sharifi
function DenoisedData = Call_Denoising(Data_Noisy)

level = 2;
bn = 'HH';


I_anyl                  = NSRFilters(Data_Noisy, ...
    'hmp-wlet',bn,'db1',level);
B                       = medfilt2(I_anyl,[5 5]);
B                       = medfilt2(B,[5 5]);
B                       = medfilt2(B,[5 5]);
DenoisedData = B;


% display('Denoising is finished ...')