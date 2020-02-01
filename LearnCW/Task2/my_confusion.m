function [CM, acc] = my_confusion( Ctrues, Cpreds )

[row,col] = size(Ctrues);
CM = zeros(26,26);

for i = 1:row
    CM(Ctrues(i),Cpreds(i)) = CM(Ctrues(i),Cpreds(i))+1;
end

diag_CM = diag(CM);

sum_diag_CM = sum(sum(diag_CM,2));
acc = (sum_diag_CM/row);

