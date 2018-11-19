max = 80000;
N_mean_val_tracker = zeros(1,max);
for Iter = 1000:max
    N_value_tracker = zeros(1,Iter);  %Matrix to keep track of N for each iteration
    for i=1:Iter
        s = 0;  %Variable to keep track of the sum
        N = 0;  %Initializing the value of N
        rand_tracker = zeros(1,100); %Matrix to keep track of the random numbers we generate
        while (s <=1)   %Checking if the sum is not greater than One
            N = N+1;    %If the sum is not greater than one, then incrementing the value of N
            x = rand;   %Generating one random variable
            rand_tracker(1,N) = x; %
            s = s + x; %Adding the random number to the previously calculating sum
        end
        %disp(s);
        %disp(N);
        N_value_tracker(1,i) = N; %Populating the N_value_tracker once the sum exceeds 1
    end
    mean_value_of_N = sum(N_value_tracker)/Iter; %Finding the mean value of N over multiple iterations
    disp(mean_value_of_N);
    N_mean_val_tracker(1,Iter-999) = mean_value_of_N;
  
     
end

figure   %Plotting a graph to check the convergence behaviour as the number of iterations increase
s = 1000:1:max;
d = N_mean_val_tracker(1,s-999);
plot(s,d);
xlabel("Number of Iterations");
ylabel("Sample mean of the experiment");


