N = 8;  %Number of Input Ports of our simulated switch. Same as the number of output ports
%Lets generate the probabilities for each of the outputs
Probability_Matrix = rand(1,N);
Probability_Matrix = Probability_Matrix/sum(Probability_Matrix);  %Generating a matrix describing the probabilities for each of the N output slots
disp(sum(Probability_Matrix));
Input_State_Matrix = zeros(1,N); %Matrix to keep track of the output slots chosen by HOL packets in one clock cycle
for i=1:N
    Input_State_Matrix(1,i) = ceil(rand*N);
end
%After we get our Initial Input state, lets find the status of HOL postions
%of each input slot.
%That is, lets find the destinations of the HOL packets on each of these
%input slots
Freq_of_Desired_Output_Matrix = zeros(1,N); %Matrix to keep track of the frequency of selection of each output slot in one clock cycle
for i=1:N
    Freq_of_Desired_Output_Matrix(1,i) = sum(Input_State_Matrix(:) == i);
end
Output_Ports_with_Higher_Demand = []; %Matrix to keep track of the output ports that are of high demand in a particular clock cycle
for i=1:N
    if(Freq_of_Desired_Output_Matrix(1,i) > 1)
        Output_Ports_with_Higher_Demand(1,i) = i;   %Matrix to keep track of which Output slots are desired by more than one input packets
    end
end
Slot_wise_Input_Queue = zeros(1,N); %Matrix to keep track of the queue size at each of the input slots
High_Demand_Port_Numbers = find(Output_Ports_with_Higher_Demand); %Matrix containing the port number with a demand greater than one
for i = drange(High_Demand_Port_Numbers)
    Slot_wise_Input_Queue(1,i) = Slot_wise_Input_Queue(1,i) + Freq_of_Desired_Output_Matrix(1,Output_Ports_with_Higher_Demand(1,i)) - 1; %For these port numbers we populate the queue based on the freq calculated
end

Temp_total_Output_packets = 0;
Output_Slot_Density = zeros(1,N);
N_alpha_tracker = zeros(1,N);
for i=1:N
    N_alpha_tracker(1,i) = N*Probability_Matrix(1,i);
    Temp_total_Output_packets = Temp_total_Output_packets + round(N*Probability_Matrix(1,i));
    Output_Slot_Density(1,i) = round(N*Probability_Matrix(1,i));
end
%for i=1:N
%    Rounded_N_alpha_tracker(1,i) = round(N_alpha_tracker(1,i));
%    if(Rounded_N_alpha_tracker(1,i) == 0)
%        Rounded_N_alpha_tracker(1,i) = 1;
%    end
%end
Rounded_N_alpha_tracker = round(N_alpha_tracker);
sum_of_rounded_N_alphas = sum(Rounded_N_alpha_tracker);
sum_of_orig_N_alphas = sum(N_alpha_tracker);
total = sum(Output_Slot_Density);
