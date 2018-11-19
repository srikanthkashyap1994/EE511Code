HOL = [5,3,4,4,4,7,7,2];
pack_sen = zeros(1,8);
U = unique(HOL);
counts = histc(HOL,U);
d = U(counts > 1);
out = find(ismember(HOL,d(1,1)));  %Positions of unique elements
%if(length(find(U)) ~= length(U))   
    %Means that there are zeros in the HOL position
    counts = counts(2:end);
    U = U(2:end);
end
for i=1:length(counts)
    if(counts(1,i) == 1)
        pack_sen(1,U(1,i)) = pack_sen(1,U(1,i)) + 1;
        HOL(1,find(HOL == U(1,i))) = 0;
    else
        d = U(counts > 1);
        k = length(d);
        out = find(ismember(HOL,d(1,k)));  %Positions of unique elements
       
    end
        
end


    

