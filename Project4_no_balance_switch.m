N = 8;  %Number of Input Ports of our simulated switch. Same as the number of output ports
%Lets generate the probabilities for each of the outputs
Probability_Matrix = zeros(1,N);
for i=1:N
    Probability_Matrix(1,i) = 1/N;
end
Output_Slot_Density = zeros(1,N);
Input_State_Matrix = zeros(1,N); %Matrix to keep track of the output slots chosen by HOL packets in one clock cycle
for i=1:N
    Output_Slot_Density(1,i) = N*Probability_Matrix(1,i); %Number of packets that are destined to each of the output slots
end

N_alpha_tracker = zeros(1,N);
for i=1:N
    N_alpha_tracker(1,i) = N*Probability_Matrix(1,i);
    
end

Rounded_N_alpha_tracker = round(N_alpha_tracker);
sum_of_rounded_N_alphas = sum(Rounded_N_alpha_tracker);
sum_of_orig_N_alphas = sum(N_alpha_tracker);
input = [];
for i=1:numel(Output_Slot_Density)
    k = Output_Slot_Density(1,i);
    for j=1:k
        input = [input,i];
        input_state = input(randperm(length(input)));
    end          
end 