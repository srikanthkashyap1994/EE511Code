maximum = 40000;    %Maximum number of iteration that we wish to do
m_tracker = zeros(1,Iter-999);  %Matrix to keep track of the sample mean of each iteration
for Iter = 1000:maximum
N_Tracker = zeros(1,Iter);  %Matrix to keep track of the value of N in each of the iterations
for j=1:Iter
    a = 0;
    N = 0;
    num_tracker = zeros(1,100);
    num_tracker(1,1) = rand;
    for i=2:100
        a = rand;
        num_tracker(1,i) = a;
        if(num_tracker(1,i)< num_tracker(1,i-1))  %Checking if the newly generated random numbers is lesser than the previous one
            N = i;     %If yes, this value of i is the N we are looking for
            N_Tracker(1,j) = N;  %Store this value of N in the matrix to keep track for future reference
            break    %Break out of the for loop as the needful is done
        end
    end
end
mean_val = sum(N_Tracker)/Iter;  %Find the mean of the collected N-values in a particular iteration
m_tracker(1,Iter-999) = mean_val; %Keep track of the mean value generated
disp(mean_val); %display this mean value
%disp(N);
end
%Plot the graph showing the variation of the sample mean value with number of iterations
f = 1000:1:maximum;  
g = m_tracker(1,f-999);
plot(f,g);
xlabel("Number of Iterations");
ylabel("Sample mean of the experiment");
