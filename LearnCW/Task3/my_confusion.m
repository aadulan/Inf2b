function [CM, acc] = my_confusion(Ctrues, Cpreds)
% Input:
%   Ctrues : N-by-1 ground truth label vector
%   Cpreds : N-by-1 predicted label vector
% Output:
%   CM : K-by-K confusion matrix, where CM(i,j) is the number of samples whose target is the ith class that was classified as j
%   acc : accuracy (i.e. correct classification rate)

[row,col] = size(Ctrues);
CM = zeros(26,26);

for i = 1:row
    CM(Ctrues(i),Cpreds(i)) = CM(Ctrues(i),Cpreds(i))+1;
end

diag_CM = diag(CM);

sum_diag_CM = sum(sum(diag_CM,2));
acc = (sum_diag_CM/row);



end
