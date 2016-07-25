function plots

global y target_history epoch t
global using_V1 using_V2 V
global u_max u_min
global filtered_u
global dV_dot_du

% y - Closed Loop
subplot(2,2,2); axis square; hold on
set(gcf,'color','w')
title('Closed Loop')

% Starting point
plot(0,y(1),'kx','markerSize',10)

plot(t(1:epoch-1),using_V1(1:epoch-1)','bo', 'markerSize',2)
plot(t(1:epoch-1),using_V2(1:epoch-1)', 'ms', 'markerSize',1)

plot(t(1:epoch-1),target_history(1:epoch-1),'rx','markerSize',3);

legend('Start','Using V_1','Using V_2','Setpoint','Target',...
    'Location','southoutside','Orientation','Horizontal')

xlabel('Time')
ylabel('y')

% Plot V_1(x)
subplot(2,2,3); axis square; hold on
title('Lyapunov Value')
plot(t(2:epoch),V(2:epoch),'bo','markerSize',2)
xlabel('Time')
ylabel('Error, V_1(xi)')

% Plot u
subplot(2,2,4); axis square; hold on
title('Control Effort u_1')
xlabel('Time')
ylabel('u_1')
plot(t(1:epoch-1),filtered_u(1:epoch-1),'bo','markerSize',2)
ylim([1.1*u_min(1) 1.1*u_max(1)])

% Plot the denominators of V1 and V2
figure
set(gcf,'color','w')
title('Values of the denominators')
plot(t(1:epoch-1),dV_dot_du(1:epoch-1,1),'b*','markerSize',2)
hold on
plot(t(1:epoch-1),dV_dot_du(1:epoch-1,2),'kx','markerSize',2)
legend('Denominator for V_1','Denominator for V_2')
xlabel('Time')
ylabel('Value of the denominator')

plot_all_states
