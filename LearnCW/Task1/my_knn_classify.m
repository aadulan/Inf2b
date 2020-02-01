function [Cpreds] = my_knn_classify(Xtrn, Ctrn, Xtst, Ks)
%Function does k-NN classification.

%Xtrn is the training data M by D
%Ctrn is the class number M by 1
%Xtst is the test data N by D
%Ks Vector of numbers with nearest neighbours L by 1
%Cpreds matrix of predicted 


% finding out the size of Xtrn and Xtst
[m,a] = size(Xtrn); 
[n,d] = size(Xtst);

% XX is N by 1 matrix
% YY is M by 1 matrix

% calculating XX and YY 
XX = repmat(sum((Xtst.^2),2),1,m); 
YY = repmat(sum((Xtrn.^2),2),1,n);   


%creating the euclidean distance formula
DI = XX-(2*Xtst*(Xtrn')) + YY';

%sorting the matrix out  with rescpect to the classes 
[DI,idx] = sort(DI,2,'ascend');

%giving the size of ks 
[row,col] = size(Ks);
%Defining Cpreds
Cpreds = zeros(n,row);

%for loop going through all the ks in KS
for j = 1:n 
    for i = 1:col
    %data = DI(1:Ks(i));
    %collects data from 1 to ks
    data_idx = idx(j,1:Ks(i));
    %gives the mode of each row to find out the class
    labels =Ctrn(data_idx);
    %stores the value into Cpreds
    Cpreds(j,i) = mode(labels);
    
    end
end
end

