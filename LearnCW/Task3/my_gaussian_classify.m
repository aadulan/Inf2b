function [Cpreds, Ms, Covs] = my_gaussian_classify(Xtrn, Ctrn, Xtst, epsilon)
% Input:
%   Xtrn : M-by-D training data matrix
%   Ctrn : M-by-1 label vector for Xtrn
%   Xtst : N-by-D test data matrix
%   epsilon : A scalar parameter for regularisation
% Output:
%  Cpreds : N-by-1 matrix of predicted labels for Xtst
%  Ms    : D-by-K matrix of mean vectors
%  Covs  : D-by-D-by-K 3D array of covariance matrices

% gets the size of the [row,col] of the training data 
[n,d]= size(Xtst);
% initalises the size of the covaraince matrix
covariance = zeros(d,d,26);

% loops going through all the classes 
for i = 1:26 
    %how many test data is in each class
    count(i,1) = sum(Ctrn ==i);
    %calculates the mean of the class 
    mean(i,:) = sum(Xtrn(Ctrn == i,:)) ./ count(i,1);
    % calculuates the covariance 
    covariance(:, :, i) = (((Xtrn(Ctrn == i,:) - repmat(mean(i,:),count(i,1),1))' *(Xtrn(Ctrn == i,:) - repmat(mean(i,:),count(i,1),1)))/count(i,1)) + (epsilon*eye(d,d));
    % does the inverse of the covariance
    inverse_covariance( :,:,i) = inv(covariance(:,:,i));
    %calculates the log det of the covariance
    log_det_cov(i,1) = logdet(covariance(:, :, i));
end

% loop going through the number of rows of the test data
for i = 1:n
        %a row of Xtst
        test_x = Xtst(i,:);
        % loop going through all the classes 
    for j = 1:26 
        % getting the log likelihood probabililites 
        log_prob(i,j) = -0.5 .*(test_x -mean(j,:)) *inverse_covariance(:,:,j)*(test_x - mean(j,:))' - 0.5*log_det_cov(j,1);
    end
    %gets the maximum of the log likelihood
    [I,idx] = max(log_prob(i,:));
    %returns the predicted class 
    Cpreds(i,1) = idx;
end
% returns the mean 
Ms = mean';
% returns the covarariance.
Covs = covariance;
end
