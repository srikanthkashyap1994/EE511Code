N = 100; %Number of runs in a sequence
random_number_tracker = zeros(1,N); %row matrix of zeros to keep track of the random numbers generated.
for i=1:N
    random_number_tracker(1,i) = rand;   %populating the matrix
end
%Now, lets find out the sample mean
mean = sum(random_number_tracker)/length(random_number_tracker); %Calculating the sample mean for one iteration
%Now, lets find out the sample variance
variance_tracker = zeros(1,N);
for i=1:N
    variance_tracker(1,i) = (random_number_tracker(1,i) - mean)^2;
end
s = sum(variance_tracker)/(N-1);  %Calculating the sample variance
%Now, lets calculate the sample variance of sample mean
fprintf("Sample mean: %f\n",mean);
fprintf("Sample variance: %f\n",s);

