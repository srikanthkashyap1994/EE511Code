N = 10; %Number of runs in a sequence
random_value_tracker = zeros(1,N);
for w=1:N
    random_value_tracker(1,w) = rand*N;
end

edges = [0:1:N];
histogram(random_value_tracker,edges); %Generating a histogram plot of the random numbers generated.
desiredvalues = histcounts(random_value_tracker); %Finding the number of entries in each of the ten bins created
disp(desiredvalues);  %Displaying these bin entries to the output console
Observed_mean = (sum(random_value_tracker)/N);  %Calculating the mean of these observed values
Observed_variance_tracker = zeros(1,N);   %Row matrix to keep track of the Observed variance of these values
for t=1:N
    Observed_variance_tracker(1,t) = (random_value_tracker(1,w) - Observed_mean)^2;
end
Observed_variance = sum(Observed_variance_tracker)/(N-1);  %Finding out the observed variance of these observed values
fprintf("The observed mean of the experiment is %f\n",Observed_mean);
fprintf("The observed variance of the experiment is %f\n",Observed_variance);
z2 = 0;
for p=1:length(desiredvalues)
    z2 = z2 + ((desiredvalues(1,p) - 100)^2)/100; %Calculating the X2(Chi-squared) values using appropriate formula
end
fprintf("The value of the statistic Z^2 is: %f\n",z2);