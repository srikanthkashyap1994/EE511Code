N = 2;  %Number of Input Ports of our simulated switch
Clock_cycles = 100; %Number of clock cycles
slots = (1:N); %Numbering of our slots
packet_count = 0;
Slot_wise_packet_count = zeros(1,N);
for v=1:N
    Input_Queue{v} = [];  %Creating Queues for each of the Input slots in case they are required
end
%edges = [0:(1/N):1]; 
%new_status = histcounts(status,edges);
%All_alphas = zeros(1,N);
%All_alphas = rand(1,N);

k = 1;
%All_alphas(1,1) = 1/k;
for i=1:N
    All_alphas(1,i) = 1/N;
    %All_alphas(1,i) = (1/(N-1))*((k-1)/k);  %Case of balanced traffic
end
All_alphas = All_alphas/sum(All_alphas);
%Matrix defining the probability that a particular output slot will be
%selected
%All_alphas = All_alphas/sum(All_alphas);


%Lets generate Alpha Matrix
Alpha_Matrix = [];
Alpha_Matrix = [Alpha_Matrix,0];
summation = 0;

%Lets define the Alpha Matrix
for i=1:N
    summation = summation + All_alphas(1,i);
    Alpha_Matrix = [Alpha_Matrix,summation];
end
%Input_status = rand(1,N);  %Initial Input state
%Alpha Matrix definition ends
for Iter=1:Clock_cycles     %Beginning the clock cycle
    temp = zeros(1,N);
    HOLBlockedSlots = [];
for i=1:N
    if(~isempty(Input_Queue{i}))   %Initially checking if the Input queues of any slots is non-empty
    temp(1,i) = Input_Queue{i}(1,1); %If yes, push the first elements of these Input queues into the temp variable
    HOLBlockedSlots = [HOLBlockedSlots,i];  %Also, include the slot numbers in the HOLBlockedSlots list for future reference
    end
end
HOLqueue_status = find(temp);
if(isempty(HOLqueue_status))
    %rng('shuffle');
    Input_status = rand(1,N);
else           %This means that there are elements in some of the input queues
    
    Prev_Queue = zeros(1,N+1);  %Taking an extra zero so that the sorted list starts from zero. Elements in the Queue from the previous clock cycle
    for i=drange(HOLqueue_status)
        Prev_Queue(1,i) = temp(1,i);
    end
        [D,Ia,Ic] = unique(Prev_Queue,'legacy');  %Checking the queued elements from the previous clock cycle
        u_slots = Ia(2:end); %u_slots contains the positions of slots with non-empty queues  %CHANGED THIS FROM D TO Ia
        for i=1:length(u_slots)  %Something is wrong in this loop
            %Input_Queue{u_slots(1,i)} = Input_Queue{u_slots(1,i)}(2:end); %Sending off the first elements of these particular slot queues
            %packet_count = packet_count + 1;
            Input_status(u_slots(1,i)) = rand; %As soon as you send the previously queued packet, the new packet is ready. But! It cant be sent in this clock cycle!
            NewPacket = discretize(Input_status(u_slots(1,i)),Alpha_Matrix); %Selecting the output for the new packet so that it can be aptly queued
            Input_Queue{i} = [Input_Queue{i},NewPacket];%Adding the newly arriving packet to the queue as it cant be sent
        end
        %Input_Queue{i}(1) = [];   %It went wrong here!(1st)
   
    free_slots = setdiff(slots,HOLqueue_status);  %Finding slots which have empty queues in this clock cycle
    for i=drange(free_slots)
        %rng('shuffle');
        Input_status(1,i) = rand;  %It went wrong here as well!(2nd)
    end
end
a = Input_status;
           
        
Slot_selection = discretize(a,Alpha_Matrix);%Selecting Output slot
disp(Slot_selection);  %Displaying slot selection for Testing
%new_edges = [0:1:N];
%freq = histcounts(Slot_selection,new_edges);
%disp(Slot_selection);
%We have to create input queues to each of the slots
for i=1:N
    Input_Queue{i} = [Input_Queue{i},Slot_selection(1,i)]; %Temporarily adding all the input packets to the Input buffer/queue
end
temp_buffer = []; %Temporary buffer used to compare the first elements of each of our input queues
for i=1:N
    temp_buffer = [temp_buffer,Input_Queue{i}(1,1)];
end
uniq = unique(temp_buffer,'first');%unique elements in the temp_buffer
[C,ia,ic] = unique(temp_buffer,'legacy'); %C is the list of sorted unique elements. Ia is the index of last occurence of these sorted unique elements
uniq_slots = ia; %list of input slots where packets with unique destination arrived.
%for i=1:N

for i=1:length(uniq_slots)
    Input_Queue{uniq_slots(1,i)} = Input_Queue{uniq_slots(1,i)}(2:end); %If there are multiple input slots wanting to go to the same output slot, we are sending the latest slot that we encountered. Packet sent
    packet_count = packet_count + 1;
    Slot_wise_packet_count(1,uniq_slots(1,i)) = Slot_wise_packet_count(1,uniq_slots(1,i)) + 1;  %Parameter to keep track of the slot-wise packet count
end

%Subsequent_State = discretize(


end

Throughput = (packet_count/Clock_cycles);
