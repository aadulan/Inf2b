function [Cpreds] = my_improved_gaussian_classify(Xtrn, Ctrn, Xtst, epsilon)
% Input:
%   Xtrn : M-by-D training data matrix
%   Ctrn : M-by-1 label vector for Xtrn
%   Xtst : N-by-D test data matrix
%  epsilon : A scalar parameter for regularisation
% Output:
%  Cpreds : N-by-1 matrix of predicted labels for Xtst
%  Ms    : D-by-K matrix of mean vectors
%  Covs  : D-by-D-by-K 3D array of covariance matrices

%YourCode - Bayes classification with multivariate Gaussian distributions.


[n,d]= size(Xtst);
[row,col] = size(Xtrn);
% Finding the mean of the colums 
Xtrn_mean = sum(Xtrn)/col;
%shifting the training data 
Xtrn_shift = bsxfun(@minus, Xtrn, Xtrn_mean);
% calculate the covariance of the training data
covar_Xtrn = 1/(row-1) * (Xtrn_shift' * Xtrn_shift);
%work out eigenvalues and eigenvectors of the covariance 
[PC,V] = eig(covar_Xtrn);
%creates a vector of all the eigenvalues
V = diag(V);
%sorts eigenvalues 
[tmp,ridx] = sort(V,1,'descend');
% takes k vectors 
k = 50;
%gets k eigenvectors 
PC = PC(:,ridx(1:k,:)); 
%tranform Xtrn
Xtrn_new = Xtrn * PC;
%transform Xtst
Xtst_new = Xtst * PC;

% continues as my_gaussian_classify
for i = 1:26 
    count(i,1) = sum(Ctrn ==i);
    mean(i,:) = sum(Xtrn_new(Ctrn == i,:)) ./ count(i,1);
    covariance(:, :, i) = (((Xtrn_new(Ctrn == i,:) - repmat(mean(i,:),count(i,1),1))' *(Xtrn_new(Ctrn == i,:) - repmat(mean(i,:),count(i,1),1)))/count(i,1)) + (epsilon*eye(d,d));
    inverse_covariance( :,:,i) = inv(covariance(:,:,i));
    
    log_det_cov(i,1) = logdet(covariance(:, :, i));
end


for i = 1:n
        test_x = Xtst_new(i,:);
    for j = 1:26 
        log_prob(i,j) = -0.5 .*(test_x -mean(j,:)) *inverse_covariance(:,:,j)*(test_x - mean(j,:))' - 0.5*log_det_cov(j,1);
    end
    [I,idx] = max(log_prob(i,:));
    Cpreds(i,1) = idx;
end
Ms = mean';
Covs = covariance;
end
