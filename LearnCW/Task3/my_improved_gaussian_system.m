%
% Template for my_improved_gaussian_system.m
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

% Run classification, measures time and displays it
tic;
epsilon = 0.01;
[Cpreds] = my_improved_gaussian_classify(Xtrn, Ctrn, Xtst, epsilon);
toc
%[Cpreds, Ms, Covs] = my_improved_gaussian_classify(Xtrn, Ctrn, Xtst);

%Measure the time taken, and display it.
%Get a confusion matrix and accuracy
[CM, acc] = my_confusion(Ctst, Cpreds);

%Save the confusion matrix as "Task3/cm_improved.mat".
save('cm_improved.mat','CM');
%Display information if any
N = size(Xtst,1)
Nerrs = N -(N * acc)
acc




  
