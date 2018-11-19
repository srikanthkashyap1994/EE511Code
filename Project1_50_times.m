Iter=50;  %Number of iterations we wish to perform
Mean_Variance_Tracker = zeros(Iter,2);
for j=1:Iter
    Project1; %Running the particular experiment once in the loop
    Mean_Variance_Tracker(j,1) = mean;  %Keeping track of the mean 
    Mean_Variance_Tracker(j,2) = s;    %Keeping track of the variance
end

figure('Name','EE511 Project1: Random Number Generation','NumberTitle','off','Color', 'Blue')                     %Creating a pop-up figure to picturize the results
l = 1:1:Iter;
mean = Mean_Variance_Tracker(l,1);
plot(l,mean);   %Plotting the variation of the value of mean with iteration
xlabel('Iteration');
ylabel('Sample means of the iterations');
title('Variation of sample means with Iteration');

figure('Name','Distribution of Sample Means','NumberTitle','off','Color', 'Red')                     %Creating a pop-up figure to picturize the results


%Now lets try to draw a frequency distribution of this sample means by the
%dividing the available sample space into 10 equal parts.

histogram(Mean_Variance_Tracker(:,1)); %Drawing the distribution histogram of the sample means
mean_of_sample_means = sum(Mean_Variance_Tracker(:,1))/Iter; %We calculate the mean of all the sample means here
Sample_Variance_Tracker = zeros(1,Iter); % A row matrix to keep track of the variance of the sample means
for q=1:Iter
    Sample_Variance_Tracker(1,q) = (Mean_Variance_Tracker(q,1) - mean_of_sample_means)^2;
end
variation_of_sample_mean = sum(Sample_Variance_Tracker)/Iter;  %Here, we calculate the Variation of the sample means
fprintf("Mean of the sample means: %f\n",mean_of_sample_means);
fprintf("Variance of the sample means: %f\n",variation_of_sample_mean);
    
