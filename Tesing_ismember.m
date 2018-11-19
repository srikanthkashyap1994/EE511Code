
HOL = [4,4,4,4,4,4,4,4,4]; 
pack_sen = zeros(1,10);
U = unique(HOL);
counts = histc(HOL,U);
d = U(counts > 1);
%Lets find counts of each repeating element in the HOL position
for i=1:length(d)
    out{i} = []; %Creating a dynamic arrays for each element that repeated
end
%out = zeros(length(d),length(HOL));  %since, each element can occur for a max of length(HOL) times
for i=1:length(d)
    out{i} = find(ismember(HOL,d(1,i)));
end
%out = find(ismember(HOL,d(1,2)));
for i=1:length(d)
    msize = numel(out{i});
    sel = out{i}(1,randperm(msize,1));  %Selecting the random element amoung the repeated ones that needs to be sent off
    %Just send off this element
    disp(sel);
end
%msize = numel(out);
%sel = out(randperm(msize,1));

%We are able to find the positions of each of the repititions.