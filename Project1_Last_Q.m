N = 1000; %Number of runs in a sequence
random_number_tracker = zeros(1,N+1);
for i=1:N+1          %Creating a row matrix of N+1 random numbers
    random_number_tracker(1,i) = rand;
end
sum_of_prod = 0;
sum1 = 0;
sum2 = 0;
for a=1:N     
    sum_of_prod = sum_of_prod + ((random_number_tracker(1,a)))*(random_number_tracker(1,a+1));
    sum1 = sum1 + random_number_tracker(1,a);
    sum2 = sum1 + random_number_tracker(1,a+1);
end
average = sum_of_prod/N;
avg1 = sum1/N;
avg2 = sum2/N;
z = average - (avg1*avg2);  %This gives us the value of Z that we are looking for
fprintf("The value of z is: %f\n",z);