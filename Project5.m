N = 8;  %Number of Input Ports of our simulated switch
Clock_cycles = 1000000; %Number of clock cycles
packets_dropped = zeros(1,N);
Slot_wise_Succ_Arr = zeros(1,N);
packets_sent = zeros(1,N); %Vector to keep track of successful packet trasmissions
Input_Queue = zeros(1,N); %Counter to keep track of number of elements in input queues of each slot
Total_Q_elements = zeros(1,Clock_cycles);
Q_elements_per_slot = zeros(N,Clock_cycles);
Slot_wise_arr_count = zeros(1,N); %Vector to count the Total number of arrivals at a single input port
%All_alphas = zeros(1,N);
%All_alphas = rand(1,N);
lambda = 0.75; %Input Probability Measure
count_HOL = zeros(N,N+1); %Variable to count the no of times a pkt at input i has output j
HOL_positions = zeros(1,N); %Variable to keep track of the HOL position elements of each input slot
max_q_size = 50; %Max Q/Buffer size at each input slot
k = 4;
All_Output_alphas(1,1) = 1/k;
%All_alphas(1,1) = 0.5;
%All_alphas(1,2) = 0.5;
for i=2:N
    %All_Output_alphas(1,i) = 1/N;
    All_Output_alphas(1,i) = (1/(N-1))*((k-1)/k);  
end
All_Output_alphas = All_Output_alphas/sum(All_Output_alphas);
%All_alphas = All_alphas/sum(All_alphas);


%Lets generate Alpha Matrix
Alpha_Output_Matrix = [];
Alpha_Output_Matrix = [Alpha_Output_Matrix,0];
summation = 0;
for i=1:N
    summation = summation + All_Output_alphas(1,i);
    Alpha_Output_Matrix = [Alpha_Output_Matrix,summation];
end
Slot_selection_ref = zeros(1,N);  %Ref random number to select output slots
%Alpha Matrix definition ends
for Iter=1:Clock_cycles     %Beginning the clock cycle and iterating over the number of clockcycles mentioned
Input_ref = rand(1,N); %Generating N ref rand nums for pkt arrival status
Slot_selection = zeros(1,N);
Input_Pkt_Arr_Status = zeros(1,N); %Variable to keep track of the packet arrival at an input slot

for i=1:N  
    if(Input_ref(1,i)< lambda) %What to do if a packet arrives at a slot i
        Input_Pkt_Arr_Status(1,i) = 1;  %1 implies packet arrival. 0 implies no packet arrival
        Slot_wise_arr_count(1,i) = Slot_wise_arr_count(1,i) + 1; %If a packet arrives, increment this
        if(Input_Queue(1,i) == 0 && HOL_positions(1,i)== 0) %If the Input Queue is empty
            Slot_selection_ref(1,i) = rand;
            Slot_selection(1,i) = discretize(Slot_selection_ref(1,i),Alpha_Output_Matrix);
            HOL_positions(1,i) = Slot_selection(1,i); %We forward that packet directly to the HOL position
            Slot_wise_Succ_Arr(1,i) = Slot_wise_Succ_Arr(1,i) + 1;
        else
            if(Input_Queue(1,i)<max_q_size)
                Input_Queue(1,i) = Input_Queue(1,i) + 1; %If the Input Queue is occupied, we put the packet in the Input queue
                Slot_wise_Succ_Arr(1,i) = Slot_wise_Succ_Arr(1,i) + 1;
            else
                packets_dropped(1,i) = packets_dropped(1,i) + 1; %We increase the packet drop count for that particular input port
            end
       
        end
    
    end       
end
%Input handling when packet arrives is done. Lets fill up all the HOL
%positions
for i=1:N
if(HOL_positions(1,i) == 0 && Input_Queue(1,i) > 0)
    Input_Queue(1,i) = Input_Queue(1,i) - 1;
    Slot_selection_ref(1,i) = rand;
    Slot_selection(1,i) = discretize(Slot_selection_ref(1,i),Alpha_Output_Matrix);
    HOL_positions(1,i) = Slot_selection(1,i); 
end
end
%Now, the HOL positions of all the slots must have been filled
%Start sending
%Now, we are calculating the no of times a pkt at input i had out j


table = tabulate(HOL_positions);
for i=1:size(table,1)
    if(table(1,1) ~= 0 && table(i,2) == 1)
        packets_sent(1,find(HOL_positions == table(i,1))) = packets_sent(1,find(HOL_positions == table(i,1))) + 1;
        count_HOL(find(HOL_positions == table(i,1)),HOL_positions(1,find(HOL_positions == table(i,1)))+1) = count_HOL(find(HOL_positions == table(i,1)),HOL_positions(1,find(HOL_positions == table(i,1)))+1) + 1;
        HOL_positions(1,find(HOL_positions == table(i,1))) = 0;   %Sending off the elements with unique output ports
    end
end
U = unique(HOL_positions);
counts = histc(HOL_positions,U);
dup = U(counts > 1);
if(length(dup)>0)
if(dup(1,1) == 0)
    d = dup(2:end);
else
    d = dup;
end
%Lets find counts of each repeating element in the HOL position
%for i=1:length(d)
%    out{i} = []; %Creating a dynamic arrays for each element that repeated
%end
%out = zeros(length(d),length(HOL));  %since, each element can occur for a max of length(HOL) times
for i=1:length(d)
    out{i} = find(ismember(HOL_positions,d(1,i)));
end
%out = find(ismember(HOL,d(1,2)));
for i=1:length(d)
    msize = numel(out{i});
    sel = out{i}(1,randperm(msize,1));  %Selecting the random element amoung the repeated ones that needs to be sent off
    %Just send off this element
    %disp(sel);
    packets_sent(1,sel) = packets_sent(1,sel) + 1;
    count_HOL(sel,HOL_positions(1,sel)+1) = count_HOL(sel,HOL_positions(1,sel)+1) + 1;
    HOL_positions(1,sel) = 0;
end
end
 Total_Q_elements(1,Iter) = sum(Input_Queue);
 for i=1:N
     Q_elements_per_slot(i,Iter) = Input_Queue(1,i);
 end
end
Avg_pkt_drops_per_input_port = sum(packets_dropped)/length(packets_dropped);
Avg_thrpt_per_input_slot = sum(packets_sent)/length(packets_sent);
System_throughput = sum(packets_sent); %Calculating system throughput
%We have sent off the packets from input slots with unique desired output
%slot

%Plotting the variation of total Q'd elements in the system with Clock
%cycle
figure
x = 1:1:Iter;
y = Total_Q_elements(1,x);
plot(x,y);
xlabel("Clock cycle");
ylabel("Total number of Queued packets in the system");


figure
z = 1:1:Iter;
w = Q_elements_per_slot(1,z);
plot(z,w);
xlabel("Clock cycle");
ylabel("Total Queued packets per port (Here, Port 1)");


%Now, lets calculate the probabities that a packet is destined to input j
Output_Port_Prob = zeros(1,N);
for i=1:N
    Output_Port_Prob(1,i) = sum(count_HOL(:,i+1))/Clock_cycles;
    
end
%Lets calculate the probability that a packet at input i is destined to
%output j

%for i=1:N
%    In_Out_port_Prob(1,i)
    
%Lets calculate the Average number of Queued elements in each slot
Avg_Q_size = zeros(1,N);
Avg_Succ_Arrv_Rate = zeros(1,N);
Waiting_times = zeros(1,N);
for i=1:N
    Avg_Q_size(1,i) = sum(Q_elements_per_slot(i,:))/Clock_cycles;
    Avg_Succ_Arrv_Rate(1,i) = Slot_wise_Succ_Arr(1,i)/Clock_cycles;
    Waiting_times(1,i) = Avg_Q_size(1,i)/Avg_Succ_Arrv_Rate(1,i);   
end
%We have calculated the Average Queue size, Average Success Arrival Rate,
%and Average Waiting times all per slot
Nij =  count_HOL(:,(2:end))/(Clock_cycles);
%Now,lets calculate lambda(i,j)
Big_Alpha_matrix = repmat(All_Output_alphas,N);
lambda_Matrix = lambda*Big_Alpha_matrix;
%Lets find the time spent in HOL i for destination j
Xij = zeros(N,N); %Matrix to keep track of service times
for i=1:N
    for j=1:N
        Xij(i,j) = Nij(i,j)/lambda_Matrix(i,j);
    end
end
%Lets find Tij which is the time from successful arrival until delivered to
%output
Tij = zeros(N,N);
for i=1:N
    for j=1:N
        Tij(i,j) = Waiting_times(1,i) + Xij(i,j);
    end
end
%Lets find this slot wise
Ti = Tij*transpose(All_Output_alphas)
%This is the final measure for the total time spent in the system



%Lets calculate the expected value of number of the elements in slot i that
%desire slot j



