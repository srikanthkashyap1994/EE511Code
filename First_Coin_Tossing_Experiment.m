n_flips=input('Enter number of samples: ');
p_est_fraction_heads=zeros(1,n_flips);% to track fraction of heads
X=rand(1,n_flips);
nh=0;
for trial=1:n_flips
if(X(trial)<=0.5) % rand <0.5 indicates Head
nh=nh+1;
end;
p_est_fraction_heads(1,trial)=nh/trial;
end
n_flips, nh
plot(p_est_fraction_heads);