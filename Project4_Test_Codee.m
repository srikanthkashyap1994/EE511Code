N = 8;  %Number of Input Ports of our simulated switch
Clock_cycles = 100000; %Number of clock cycles
slots = (1:N); %Numbering of our slots
packet_count = 0;
Slot_wise_packet_count = zeros(1,N); %row matrix to keep track of packets sent to each of the output ports
for v=1:N
    Input_Queue{v} = []; %Creating Queues for each of the Input slots in case they are required
end
%All_alphas = zeros(1,N);
%All_alphas = rand(1,N);

k = 8;
All_alphas(1,1) = 1/k;
%All_alphas(1,1) = 0.5;
%All_alphas(1,2) = 0.5;
for i=2:N
    %All_alphas(1,i) = 1/N;
    All_alphas(1,i) = (1/(N-1))*((k-1)/k);  
end
All_alphas = All_alphas/sum(All_alphas);
%All_alphas = All_alphas/sum(All_alphas);


%Lets generate Alpha Matrix
Alpha_Matrix = [];
Alpha_Matrix = [Alpha_Matrix,0];
summation = 0;
for i=1:N
    summation = summation + All_alphas(1,i);
    Alpha_Matrix = [Alpha_Matrix,summation];
end

%Alpha Matrix definition ends
for Iter=1:Clock_cycles     %Beginning the clock cycle and iterating over the number of clockcycles mentioned
Input_status = rand(1,N);   %Generating n random numbers each between 0 and 1
a = Input_status;
Slot_selection = discretize(a,Alpha_Matrix);%Selecting Output slot
%disp(Slot_selection);  %Displaying slot selection for Testing
for i=1:N
    Input_Queue{i} = [Input_Queue{i},Slot_selection(1,i)]; %Temporarily adding all the input packets to the Input buffer/queue
end
temp_buffer = []; %Temporary buffer used to compare the first elements of each of our input queues
for i=1:N
    temp_buffer = [temp_buffer,Input_Queue{i}(1,1)];
end
[C,ia,ic] = unique(temp_buffer,'legacy'); %C is the list of sorted unique elements. Ia is the index of last occurence of these sorted unique elements
uniq_slots = ia; %list of input slots where packets with unique destination arrived.


for i=1:length(uniq_slots)
    Input_Queue{uniq_slots(1,i)} = Input_Queue{uniq_slots(1,i)}(2:end); %If there are multiple input slots wanting to go to the same output slot, we are sending the latest slot that we encountered. Packet sent
    packet_count = packet_count + 1;
    Slot_wise_packet_count(1,uniq_slots(1,i)) = Slot_wise_packet_count(1,uniq_slots(1,i)) + 1;  %Parameter to keep track of the slot-wise packet count
end


end
fprintf("The total number of packets sent by the switch in 1 second is %d",packet_count*10); %Note that we are doing 10^5 clock cycles here. Thats the reason for multiplication with 10
fprintf("\nThe total number of packets sent per slot by the switch in 1 second is %d",(packet_count*10)/N);
Throughput = (packet_count/Clock_cycles)  %Number of packets per clock cycle
