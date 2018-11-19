N = 100;   %Number of random numbers we wish to examine
rand_val_tracker = zeros(1,N); %zero matrix to keep track of the random numbers generated
X_tracker = zeros(1,N);  %Matrix to keep track of the records created as we traverse through the random numbers generated
X_tracker(1,1) = 1;  %Distance of the first record
for i=1:N
    rand_val_tracker(1,i) = rand; %Populating the random value matrix 
end
record = rand_val_tracker(1,1);  %Initializing the record parameter with the first value encoutered while traversing through the random value matrix
for i=2:N
    if(rand_val_tracker(1,i) > record)  %Checking if the subsequently encoutered values of random numbers are greater than the already stored record
        record = rand_val_tracker(1,i); %If yes, we replace the record with this new entry
        X_tracker(1,i) = i; %We keep track of the location of this record for future reference
    end
end
%disp(record);
my_ans = find(X_tracker); %We seperate the location of the records 
result_tracker = zeros(1,N); %Matrix to keep track of the distances between these records
for i=1:(numel(my_ans)-1) 
    diff = (my_ans(1,i+1) - my_ans(1,i)); %We calculate the distance between records using the difference between their locations
    result_tracker(1,i+1) = diff;
    %disp(diff);
end
X1 = 1;  %Extracting relevant details from the result_tracker matrix
X2 = result_tracker(1,2);
X3 = result_tracker(1,3);
X4 = result_tracker(1,4);
%fprintf("The Value of X1 is %d\n",X1);
%fprintf("The Value of X2 is %d\n",X2);
%fprintf("The Value of X3 is %d\n",X3);
%fprintf("The Value of X4 is %d\n",X4);

