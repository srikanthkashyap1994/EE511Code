Iter = 5000;   %Parameter to define the number of iterations that we wish to do
Result_Tracker = zeros(Iter,4); %Defining a row matrix to keep track of the results in each iteration
disp(Result_Tracker);   %Displaying the empty matrix for reference
for p=1:Iter          %Starting the Iterations
    Project0_Coin_Tossing_Experiment_Part2;   %Performing the experiment once
    Result_Tracker(p,1) = S1;           %Storing the results in appropriate parameters
    Result_Tracker(p,2) = S2;
    Result_Tracker(p,3) = S3;
    Result_Tracker(p,4) = S4;
    
end
disp(Result_Tracker);  %Displaying the final Result Tracker for reference

figure('Name','EE511 Project0: Tossing a Coin','NumberTitle','off','Color', 'Cyan')  %Initiating a pop-up figure with customized configuration
subplot(4,1,1);        %Defining the parameters for the first grid of the total four grids
a = 1:1:Iter;
b = Result_Tracker(a,1);
plot(a,b);
title('Variation of S1 over 5000 iterations');
xlabel('Iteration');
ylabel('Value of S1');

subplot(4,1,2);      %Defining the parameters for the second grid of the total four grids
c = 1:1:Iter;
d = Result_Tracker(c,2);
plot(c,d);
title('Variation of S2 over 5000 iterations');
xlabel('Iteration');
ylabel('Value of S2');

subplot(4,1,3);    %Defining the parameters for the third grid of the total four grids
e = 1:1:Iter;
f = Result_Tracker(e,3);
plot(e,f);
title('Variation of S3 over 5000 iterations');
xlabel('Iteration');
ylabel('Value of S3');

subplot(4,1,4);   %Defining the parameters for the last grid
g = 1:1:Iter;
h = Result_Tracker(g,4);
plot(g,h);
title('Variation of S4 over 5000 iterations');
xlabel('Iteration');
ylabel('Value of S4');


