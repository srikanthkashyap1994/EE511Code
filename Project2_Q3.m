N=1000000;  %Sample size
SiX_Value_Tracker = zeros(1,N);  %To Keep track of Si(x) = (sinx)/x values that we generate
for i=1:N
    k = rand;
    SiX_Value_Tracker(1,i) = sin(k*pi)/(k); %Generate N values of the function Si(x)
end

Mean_Value = sum(SiX_Value_Tracker)/N;%Using the strong law of large numbers to find an estimate
fprintf("Estimated value of Y (Mean) is %f\n",Mean_Value);
%disp(Mean_Value);   %DISPLAY 1
Squared_diff = 0;
for i=1:N
    Squared_diff = Squared_diff + (SiX_Value_Tracker(1,i) - Mean_Value)^2;
end
Sample_Variance = (Squared_diff/(N-1));

Sample_Variance_of_our_Est = (Sample_Variance/N);%By the Defn of Central Limit Theorem
%disp(Sample_Variance); 
%disp(Sample_Variance_of_our_Est);
Sample_Std_Dev_of_Est = (Sample_Variance_of_our_Est)^(0.5);
fprintf("Estimated Standard Deviation of Sample means (By Central Limit theorem) is %f\n",Sample_Std_Dev_of_Est);
%disp(Sample_Std_Dev_of_Est);   %DISPLAY 2
Conf_Interval_Lower_Bound = Mean_Value - 2*(Sample_Std_Dev_of_Est);  %Lower Bound for our 95% confidence interval
Conf_Interval_Upper_Bound = Mean_Value + 2*(Sample_Std_Dev_of_Est);  %Upper Bound for our 95% confidence interval
fprintf("So, our calculated confidence interval with 95 percent probability is (%f,%f)\n\n\n\n",Conf_Interval_Lower_Bound,Conf_Interval_Upper_Bound);
%disp(Conf_Interval_Lower_Bound);  %DISPLAY 3
%disp(Conf_Interval_Upper_Bound);  %DISPLAY 4
    