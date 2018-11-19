x = 0:pi/100:2*pi;  %Assigning X-axis from 0 to 2pi
y = sin(x);         %On Y-axis, we plot the corresponding Sine curve
plot(x,y,'-.or')    %Plotting x and y with dash-dot-circle line in Red color
xlabel('x')         %Labelling the X-axis on plot
ylabel('Sin(x)')    %Labelling the Y-axis on plot
title('The Graph of a Sine Function') %Naming the plot
