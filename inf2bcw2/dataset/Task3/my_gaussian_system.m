%
% Template for my_gaussian_system.m
%
% load the data set
%   NB: replace <UUN> with your actual UUN.
load('/afs/inf.ed.ac.uk/group/teaching/inf2b/cwk2/d/s1631442/data.mat');

% Feature vectors: Convert uint8 data to double, and divide by 255.
Xtrn = double(dataset.train.images) ./ 255.0;
Xtst = double(dataset.test.images) ./ 255.0;
% Labels
Ctrn = dataset.train.labels;
Ctst = dataset.test.labels;

% Run classification and measures time 
tic;
epsilon = 0.01;
[Cpreds, Ms, Covs] = my_gaussian_classify(Xtrn, Ctrn, Xtst, epsilon);
toc

%Get a confusion matrix and accuracy
[CM, acc] = my_confusion(Ctst, Cpreds);


%Save the confusion matrix as "Task3/cm.mat".
save('cm.mat', 'CM');
m26 = Ms(:,26);
cov26 = Covs(:,:,26);
%saves the mean and covariance of class 26
save('m26.mat','m26');
save('cov26.mat','cov26');
%Displays required information
N = size(Xtst,1)
Nerrs = N -(N * acc)
acc






  
