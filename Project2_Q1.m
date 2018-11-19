Est_Value_Tracker = zeros(1,100000000);
max_samples = 100;
for N=100:max_samples
    points_tracker = zeros(2,N);  % A 2xN matrix to keep track of the coordinates of the N points
    distance_tracker = zeros(1,N);  % A 1xN matrix to keep track of the distance of these points from the origin
    RV_Value_tracker = zeros(1,N); %Our RV value = 1 or 0 depending on the distance. This matrix keeps track of that binary value
    num_of_inside_points = 0;  %Variable to count the number of points that lie inside the quadrant
    for i=1:N
        x = rand;  %generate a random x-coordinate
        y = rand;  %generate a random y-coordinate
        points_tracker(1,i) = x; %populating the points_tracker
        points_tracker(2,i) = y;
        d = ((x^2)+(y^2))^(0.5); %calculating the distance from origin
        if(d<=1)                   %checking if the distance is less than or equal to one
            RV_Value_tracker(1,i) = 1;   %If yes, we assign a value of 1 to that point
        else
        RV_Value_tracker(1,i) = 0;   %If no, we assign a value of 0 to that point
    end
    distance_tracker(1,i) = d;   %populating the distance_tracker matrix
end
num_of_inside_points = sum(RV_Value_tracker);  %calculating the number of points that fall inside the quadrant
%disp(distance_tracker);
%disp(num_of_inside_points);
estimated_value = (num_of_inside_points/N);  %This is the expected value of the 'pi/4' ^p (p-cap) that we are looking for
disp(estimated_value);%estimated value of pi/4 (Sample Mean)
Est_Value_Tracker(1,N-99) = estimated_value;
%disp(estimated_value*4); %estimated value of pi
%q = sum(distance_tracker)/(N-1);
%disp(4*q);
%Now, let us find the sample variance
sq_diff = 0;
for j=1:N
    sq_diff = sq_diff + (RV_Value_tracker(1,j)-estimated_value)^2;  %Calculating the squared differences of each of the values in the RV_Value_Tracker with the sample mean calculated
end
sample_variance = sq_diff/(N-1);  %Calculating the unbiased sample variance
%disp(sample_variance);
sample_standard_deviation = (sample_variance)^(0.5); %Calculating the unbiased sample standard deviation
disp(sample_standard_deviation);
Est_Var_of_sample_means = sample_variance/N; %Using the Central Limit Theorem
%disp(Est_Var_of_sample_means);
Est_StdDev_of_sample_means = (Est_Var_of_sample_means)^(0.5);
%disp(Est_StdDev_of_sample_means);
%Testing
%Let us calculate zscores and check
true_mean = 0.7854;
%true_variance = 0.1685;
%true_std = 0.4105/(N^(0.5));
z = (estimated_value - true_mean)/Est_StdDev_of_sample_means;
%disp(z);
end
figure
n=100:1:max_samples;
m=4*Est_Value_Tracker(1,n-99);
plot(n,m);
xlabel('Number of Samples');
ylabel('Estimated value of Pi');

t = [0.5:0.1:1];
norm = normpdf(t,estimated_value,Est_StdDev_of_sample_means);
figure;
plot(t,norm);

N_value = (196 * sample_standard_deviation/estimated_value)^2;  %This should be the maximum sample size according to our requirement
display(N_value);


    