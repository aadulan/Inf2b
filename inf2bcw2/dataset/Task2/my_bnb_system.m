%
% Template for my_bnb_system.m
%
% load the data set
%   NB: replace <UUN> with your actual UUN.
load('/afs/inf.ed.ac.uk/group/teaching/inf2b/cwk2/d/s1631442/data.mat');

% Feature vectors: Convert uint8 data to double (but do not divide by 255)
Xtrn = double(dataset.train.images);
Xtst = double(dataset.test.images);
% Labels
Ctrn = dataset.train.labels;
Ctst = dataset.test.labels;

% Run classification and measure the time taken and display it 
tic;
threshold = 1;
Cpreds = my_bnb_classify(Xtrn, Ctrn, Xtst, threshold);
toc
% Get a confusion matrix and accuracy
[CM,acc] = my_confusion(Ctst,Cpreds);

%Save the confusion matrix as "Task2/cm.mat".
save('cm.mat', 'CM');

N = size(Xtst,1)
Nerrs = N - (N * acc) 

acc

  
