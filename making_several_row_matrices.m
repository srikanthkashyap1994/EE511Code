slots = (1:N);
test = [1,0,2,0];  %First elements in each input slot queue
Q_status = find(test);  %Finding if there are any non zero elements in any of the input slot queues
free_slots = setdiff(slots,Q_status);

for i = drange(Q_status)   %For all these slots we send the first element in the input slot first before accepting a new element into the buffer
    Input_Queue{i} = Input_Queue{i}(2:end);
    