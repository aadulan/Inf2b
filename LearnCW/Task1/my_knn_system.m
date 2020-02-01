
%Template for my_knn_system.m

%load the data set

load('/afs/inf.ed.ac.uk/group/teaching/inf2b/cwk2/d/s1631442/data.mat');

%Feature vectors: Convert uint8 data to double, and divide by 255.
Xtrn = double(dataset.train.images) ./ 255.0;
Xtst = double(dataset.test.images) ./ 255.0;
%Labels
Ctrn = dataset.train.labels;
Ctst = dataset.test.labels;

% Run K-NN classification and measures the time and displays it 
tic;
kb = [1,3,5,10,20];
Cpreds = my_knn_classify(Xtrn, Ctrn, Xtst, kb);
toc

%size of test data 
[n,d] = size(Xtst);
%size of kb 
[row,col] = size(kb);
%for loop going through all the k values 
for i = 1:col
    %takes the column of predicted class for k nearest values
    C_k = Cpreds(:, i);
    %calculates the confusion matrix 
    [CM,acc] = my_confusion(Ctst,C_k);
    %allows to name the file cmi
    name = strcat('cm',num2str(kb(:,i)));
    %saves the file 
    save(strcat(name,'.mat'),'CM');
    %outputs k
    k = i
    %outputs the size of test data 
    N = n
    %wrongly classifed data
    Nerrs = n - (acc * n)
    %accuracy
    acc
    
end