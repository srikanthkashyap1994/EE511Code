Num = 100; %This Variable defines the Number of times we wish to flip the coin. Not asking the user
NH = 0; %Initializing a variable to store the number of Heads that occur in the experiment
flip_tracker = zeros(1,100); %Declaring a row matrix with zeroes to keep track of the random number (0,1) generated in each of the coin flips
for k=1:Num            %Simulating the experiment the number of times as in 'Num' variable
    flip_tracker(1,k) = rand; %Assigning a Random value between 0 and 1.
    if flip_tracker(1,k) < 0.5  %Validating if the random value generated is less than 0.5
        NH = NH + 1;                 %If yes, then it is considered to be a Heads. So, increasing the Heads count
    end                               %End If clause
end                                  %End for loop
%disp(flip_tracker(1:Num));   %Displaying the random values generated in each of the iteration
%fprintf('Number of Heads is: %d\n',NH); %Printing the Number of Heads that occured
j = 0; %Initiating a variable to save the length of longest run of heads
longest_run_tracker = zeros(1,100); %Initiating a row matrix to keep track of the change in above variable 'j'
for i=1:Num
    if(flip_tracker(1,i)<0.5)
        j = j+1;                          %If its a head, then incrementing the tracker variable - 'j'
        longest_run_tracker(1,i) = j;
    else
        j = 0;                       %If we encounter a tail, then we reset the tracker variable - 'j' to start again from 0.
        continue;
    end
end
%Now that we have a row matrix with all the longest runs recorded, we can
%just traverse through the matrix to find the corresponding values of
%S1,S2,S3,S4 as required
for z = 1:Num
    if (longest_run_tracker(1,z) == 1)
        S1 = z;
        fprintf('S1 = %d\n',S1);  %Extract the recorded value of S1 from the longest_run_tracker matrix and print
        break
    end
end
for z = 1:Num
    if (longest_run_tracker(1,z) == 2)
        S2 = z;
        fprintf('S2 = %d\n',S2);  %Extract the recorded value of S2 from the longest_run_tracker matrix and print
        break
    end
end
for z = 1:Num
    if (longest_run_tracker(1,z) == 3)
        S3 = z;
        fprintf('S3 = %d\n',S3);  %Extract the recorded value of S3 from the longest_run_tracker matrix and print
        break
    end
end
for z = 1:Num
    if (longest_run_tracker(1,z) == 4)
        S4 = z;
        fprintf('S4 = %d\n',S4);  %Extract the recorded value of S4 from the longest_run_tracker matrix and print
        break
    end
end

%This script can be ran multiple times (5000 here) by using an other script
%Run_Project0_Part2_5000_times.m
