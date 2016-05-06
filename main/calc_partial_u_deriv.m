function calc_partial_u_deriv

% Numerically calculate
% dx1_dot/du
% dx2_dot/du
% according to the model.

global x t epoch num_inputs num_states
global dx_dot_du f_at_u_0
global model_file delta_t
global default_fully_actuated %Use the standard method or the method for integrators/underactuated systems?


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Base case.
% Open loop.
% Compare against this.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

zero_input = zeros(1,num_inputs);

% Calculate [x1_dot; x2_dot] at this point.
% Run it for (num_states) epochs so that integration effects can be seen

x_traj = eval( strcat(model_file, '(t(epoch), x(epoch,:), zero_input)') );

if default_fully_actuated== 0 % Use the partial derivative calculation method for integrators
    % If there's only 1 state, the first x_traj calc is enough
    % Don't worry about integrators
    if num_states>1
        
        % Integrate to get a new x
        x_integrated = x(epoch,:)+x_traj(1:num_states)*delta_t;
        
        temp_t = t(epoch)+delta_t;
        
        % Run however many times more for the control effort to trickle thru
        % to every state.
        if (num_states>=3)
            for i=1 : num_states-2
                x_traj = eval( strcat(model_file, '(temp_t, x_integrated, zero_input)') );
                
                % Integrate to get a new x
                x_integrated = x_integrated+x_traj(1:num_states)*delta_t;
                
                temp_t = temp_t+delta_t;
            end
        end
        
        % By now, u will have affected every state in a system of integrators
        x_traj = eval( strcat(model_file, '(temp_t, x_integrated, zero_input)') );
    end
end


for i=1: num_states
    f_at_u_0(i)= x_traj(i);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Now apply each control input and see how it changes [x1_dot; x2_dot]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1: num_inputs
    
    delta_u = zeros(num_inputs,1);
    delta_u(i) = 1;
    
    % Run model for (num_states) epochs so that integration effects can be seen
    
    x_traj = eval( strcat(model_file, '(t(epoch), x(epoch,:), delta_u )' ));
   
    if default_fully_actuated== 0 % Use the partial derivative calculation method for integrators
        % If there's only 1 state, the first x_traj calc is enough
        % Don't worry about integrators
        if num_states>1
            
            % Integrate to get a new x
            x_integrated = x(epoch,:)+x_traj(1:num_states)*delta_t;
            
            temp_t = t(epoch)+delta_t;
            
            % Run however many times more for the control effort to trickle thru
            % to every state.
            if (num_states>=3)
                for i=1 : num_states-2
                    x_traj = eval( strcat(model_file, '(temp_t, x_integrated, delta_u)') );
                    
                    % Integrate to get a new x
                    x_integrated = x_integrated+x_traj(1:num_states)*delta_t;
                    
                    temp_t = temp_t+delta_t;
                end
            end
            
            % By now, u will have affected every state in a system of integrators
            x_traj = eval( strcat(model_file, '(temp_t, x_integrated, delta_u)') );
            
        end
    end
    
    for j=1: num_states
        
        % How did application of this control effort change dx_dot_du
        % compared to open-loop?
        dx_dot_du(i,j) = (x_traj(j)-f_at_u_0(j)); %/delta_u(i); --> delta_u(i) is 1, so it's neglected for speed
    end
end