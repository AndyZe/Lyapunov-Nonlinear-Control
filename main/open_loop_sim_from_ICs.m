function open_loop_sim_from_ICs

global num_inputs num_states
global x_IC start_time stop_time stiff_system target_x
global plant_file

disp(' ')
disp('Starting open loop sim.')

% Set target_x to a zero-vector for open-loop sim. Restore it at the end.
% Needs to be set to zero so it doesn't cause a coordinate frame
% translation.
temp_targets = target_x;
target_x= 0*target_x;

% Add the input. All zeros in this case, b/c it's open-loop
u = zeros(1,num_inputs);

t_span= [start_time stop_time];

figure(1) % The master plot with handle 1
axis square; subplot(2,2,1); axis square; hold on
title('Open Loop')

options=odeset('Vectorized','on');

% Simulate
if stiff_system
    [time, x_traj] = ode23s( str2func(plant_file),...
        t_span, [x_IC, u], options );
else
    [time, x_traj] = ode23( str2func(plant_file),...
        t_span, [x_IC, u], options );
end


if num_states == 1
    % Starting point
    plot(0,x_traj(1,1),'kx','markerSize',10)
    
    legend('Start')
    
    plot(time,x_traj(:,1),'bo','markerSize',2);
    
    xlabel('Time')
    ylabel('x_1')
end


if num_states >= 2

    % Plot starting point
    plot(x_traj(1,1),x_traj(1,2),'kx','markerSize',10);
    
    % Plot target for each epoch
    if num_states >= 2
        global delta_t
        for t = start_time : delta_t : stop_time
            epoch = 1; % Always look at t(1)
            target=eval(temp_targets);
            plot(target(1),target(2),'rx','markerSize',10);
        end
    end
    legend('Start','Target');
    
    % Plot trajectory
    plot( x_traj(:,1), x_traj(:,2), 'bo', 'markerSize',2 );
    
    xlabel('x_1')
    ylabel('x_2')
end

% Restore target_x
target_x=temp_targets;