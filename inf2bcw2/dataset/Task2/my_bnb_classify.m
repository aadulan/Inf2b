function [Cpreds] = my_bnb_classify(Xtrn, Ctrn, Xtst, threshold)
% Input:
%   Xtrn : M-by-D training data matrix
%   Ctrn : M-by-1 label vector for Xtrn
%   Xtst : N-by-D test data matrix
%   threshold : A scalar parameter for binarisation
% Output:
%  Cpreds : N-by-1 matrix of predicted labels for Xtst


%YourCode - binarisation of Xtrn and Xtst.
%binary representation of Xtrn and Xtst
bin_Xtrn = Xtrn >= threshold ;
bin_Xtst = Xtst >= threshold ;

% Needing the size of 
[n,d] = size(bin_Xtrn);
N_C = size(Ctrn,1);
N_S = size(bin_Xtst,1);

%prior probability
prior = 1/ 26;



%Calculating the likelihoods for the classes 
for i = 1:26
    count_c(i,1) = sum(Ctrn == i);
    
    Prob_1(i,:) = sum(bin_Xtrn(Ctrn ==i,:)) ./ count_c(i,1);
    Prob_0(i,:) = 1-Prob_1(i,:) ;
end

%Using naive bayes to predict the class
% goimg through each row
for i = 1:N_S
    test_x = bin_Xtst(i,:);
    %going through each class 
    for j = 1:26 
        zero = prod(Prob_1(j,test_x == 1));
        one = prod(Prob_0(j,test_x== 0));
        bayes(i,j) = zero * one;
    end
    %calculates the maximum class 
     [I,idx] = max(bayes(i,:));
%going through the test data to classify the prediction class

%YourCode - naive Bayes classification with multivariate Bernoulli distributionsx(bayes(i,:));
     %inserts the class into Cpreds
    Cpreds(i,1) = idx;
end
end
