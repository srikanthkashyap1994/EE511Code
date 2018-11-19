N = 10000; %Number of cards in our experiment which is also the same as the number of times we pick a card
random_value_tracker = zeros(1,N);
for w=1:N
    random_value_tracker(1,w) = round(rand*N);   %Generating a random value between 0 and N
end

edges = [0:1:N];    
histogram(random_value_tracker,edges); %Generating a histogram plot of the random numbers generated.
desiredvalues = histcounts(random_value_tracker,edges); %Finding the number of entries in each of the bins created
%disp(desiredvalues);%Displaying these bin entries to the output console
Frequency_Tracker = zeros(1,N); %Zero matrix to keep track of the number of cards that appear j times (let's say)
for m=1:N
    a = desiredvalues(1,m);
    Frequency_Tracker(1,a+1) = Frequency_Tracker(1,a+1) + 1;
end
%disp(Frequency_Tracker);
p0 = Frequency_Tracker(1,0+1)/N; %Now, calculating the number of cards that appeared zero times
p1 = Frequency_Tracker(1,1+1)/N; %Calculating the number of cards that appeared one time
p2 = Frequency_Tracker(1,2+1)/N; %Calculating the number of cards that appeared two times
p3 = Frequency_Tracker(1,3+1)/N; %Calculating the number of cards that appeared three times
p4 = Frequency_Tracker(1,4+1)/N; %Calculating the number of cards that appeared four times
p5 = Frequency_Tracker(1,5+1)/N; %Calculating the number of cards that appeared five times
p6 = Frequency_Tracker(1,6+1)/N; %Calculating the number of cards that appeared six times
p7 = Frequency_Tracker(1,7+1)/N; %Calculating the number of cards that appeared seven times
p8 = Frequency_Tracker(1,8+1)/N; %Calculating the number of cards that appeared eight times
p9 = Frequency_Tracker(1,9+1)/N; %Calculating the number of cards that appeared nine times
%p10 = Frequency_Tracker(1,10+1)/N; %Calculating the number of cards that appeared ten times    
fprintf("p0 = %f\n",p0);%Displaying the calculated values
fprintf("p1 = %f\n",p1);
fprintf("p2 = %f\n",p2);
fprintf("p3 = %f\n",p3);
fprintf("p4 = %f\n",p4);
fprintf("p5 = %f\n",p5);
fprintf("p6 = %f\n",p6);
fprintf("p7 = %f\n",p7);
fprintf("p8 = %f\n",p8);
fprintf("p9 = %f\n",p9);
fprintf("p10 = %f\n",p10); %We assumed that it is unlikely that a card will appear more than 10 times. So, we stop at p10.
