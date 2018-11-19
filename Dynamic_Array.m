my_array = [];
ref = [2,3,1,4];
num_of_elements = sum(ref);

for i=1:numel(ref)
    k = ref(1,i);
    for j=1:k
        my_array = [my_array,i];
    end          
end
