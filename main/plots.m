function plots

global y target_history epoch t
global using_V2 using_V3 V
global u_max u_min
global filtered_u

% y - Closed Loop
subplot(2,2,2); axis square; hold on
set(gcf,'color','w')
title('Closed Loop')

% Starting point
plot(0,y(1),'kx','markerSize',10)

plot(t(1:epoch-1),using_V2(1:epoch-1)', 'ms', 'markerSize',4)
plot(t(1:epoch-1),using_V3(1:epoch-1)', 'cs', 'markerSize',4)

plot(t(1:epoch-1),target_history(1:epoch-1),'rx','markerSize',3);

legend('Start','Using V2','Using V3','Target',...
    'Location','southoutside','Orientation','Horizontal')

plot(t(1:epoch-1),y(1:epoch-1),'bo','markerSize',2)

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

plot_all_states
