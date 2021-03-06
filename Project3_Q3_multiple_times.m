Iter = 200000;   %Number of times we wish to repeat the calculation of records
X2_tracker = zeros(1,Iter); %Matrix to keep track of the values of X2 in these multiple iterations
X3_tracker = zeros(1,Iter); %Matrix to keep track of the values of X3 in these multiple iterations
for r=1:Iter
    Project3_Q3;
    X2_tracker(1,r) = result_tracker(1,2);  %Populating X2 and X3 tracker matrices
    X3_tracker(1,r) = result_tracker(1,3);
end
%Plotting the frequency histograms for X2 and X3 values calculated
figure
o = 1:1:Iter;
p = X2_tracker(1,o);
%plot(o,p);
%xlabel('Iteration');
%ylabel('Variation of X2 with Iteration');
edges1 = 0:1:(max(X2_tracker)+10);
subplot(2,1,1);
histogram(X2_tracker,edges1);
xlabel('Value of X2');
ylabel('Frequency');
title('Frequency histogram of X2');
X2_values = histcounts(X2_tracker,edges1);

edges2 = 0:1:(max(X3_tracker)+10);
subplot(2,1,2);
histogram(X3_tracker,edges2);
xlabel('Value of X3');
ylabel('Frequency');
title('Frequency histogram of X3');
X3_values = histcounts(X3_tracker,edges2);
%Calculating the sample means from the above distributions
Sample_mean_of_X2_dist = sum(X2_tracker)/numel(X2_tracker);
Sample_mean_of_X3_dist = sum(X3_tracker)/numel(X3_tracker);
disp(Sample_mean_of_X2_dist);
disp(Sample_mean_of_X3_dist);


    