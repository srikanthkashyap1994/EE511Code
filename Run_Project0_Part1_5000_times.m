Iter = 5000;    %Number of Iterations we wish to do
Result_Tracker = zeros(Iter,4);   %Matrix to keep track of the different results of each iteration
disp(Result_Tracker);         %Display the empty Result Tracker Matrix
for p=1:Iter                     %Starting the repitition of the experiment
    Project0_Coin_Tossing_Experiment_Part1; %Run the experiment
    Result_Tracker(p,1) = NH;           %Record the NH in the first column
    Result_Tracker(p,2) = LH;           %Record the LH in the second column
    Result_Tracker(p,3) = (NH/Num); %Relative Frequency of the Number of Heads that occur
    Result_Tracker(p,4) = (LH/Num); %Relative Frequency of the Longest, stretch of heads in a iteration
end
disp(Result_Tracker);              %Displaying the completed Result matrix

Mean = (sum(Result_Tracker(:,1))/5000);   %Finding the mean value of NH over 5000 iterations

figure('Name','EE511 Project0: Tossing a Coin','NumberTitle','off','Color', 'Green')                     %Creating a pop-up figure to picturize the results
l = 1:1:Iter;
m = Result_Tracker(l,1);
subplot(4,1,1);             %Dividing the area into 4 grids and defining the axes for the first grid
plot(l,m);
xlabel('Iteration');
ylabel('NH');
title('Variation of NH with Iteration');

n = 1:1:Iter;
o = Result_Tracker(n,2);
subplot(4,1,2);           %Defining the axes for the second grid
plot(n,o);
xlabel('Iteration');
ylabel('LH');
title('Variation of LH with Iteration');

q = 1:1:Iter;
r = Result_Tracker(q,3);
subplot(4,1,3);        %Defining the axes for the third grid
plot(q,r);
xlabel('Iteration');
ylabel('Relative Freq of NH');
title('Variation of Rel Freq of NH with Iteration');

s = 1:1:Iter;
t = Result_Tracker(s,4);
subplot(4,1,4);       %Defining the axes for the last grid
plot(s,t);
xlabel('Iteration');
ylabel('Relative Freq of LH');
title('Variation of Rel Freq of LH with Iteration');