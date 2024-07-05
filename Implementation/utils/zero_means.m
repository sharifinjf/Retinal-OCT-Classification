% Zero means
function params_data = zero_means(params_data)
% convert the data to zero mean and unit standard deviation
X = params_data.X;
N = params_data.N;
Nx = params_data.Nx;
Ny = params_data.Ny;

for i=1:Nx*Ny
    mi = mean(X(:,i));
    X(:,i) = X(:,i) - mi;
    if(length(find(X(:,i)==0))<N)
        X(:,i) = X(:,i)/std(X(:,i));
        %X(:,i) = X(:,i)/norm(X(:,i));
    end
end

params_data.X = X;
end