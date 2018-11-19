NUM = 1000; %Number of times to calculate the mean
N_mean_value_tracker = zeros(1,NUM-100); %Matrix to keep track of the mean
for y = 100:NUM
    Project3_Q1;
    N_mean_value_tracker(1,y-99) = mean_value_of_N;
end
v = 100:1:NUM;
b = N_mean_value_tracker(1,v-99);
plot(v,b);   %Plotting the variation of the mean value with the number of iterations

    