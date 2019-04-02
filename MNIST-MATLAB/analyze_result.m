load images_tst
load labels_tst

result_tst = myNN15(images_tst);

n = 10000;
[val, pos] = max(result_tst);
labels_result = zeros(n, 1);
for i=1 : n
    labels_result(i) = pos(i)-1;
end

error_tst = zeros(1, n);
for i=1 : n
    if (labels_tst(i) == labels_result(i))
        error_tst(i)=0;
    else
        error_tst(i)=1;
    end
end

num_of_errors = sum(error_tst);
error_rate = (num_of_errors / n) * 100

