function calc_partial_u_deriv

% Numerically calculate
% dx1_dot/du
% dx2_dot/du
% according to the model.

global x t epoch num_inputs num_states
global dx_dot_du f_at_u_0
global model_file


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Base case.
% Open loop.
% Compare against this.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Simulate for each (x1,x2) point (open loop)
zero_input = zeros(1,num_inputs);

% [x1_dot; x2_dot] at this point:
% Run the model in the true coordinate frame.
x_traj = eval( strcat(model_file, '(t(epoch), x(epoch,:), zero_input)') );
for i=1: num_states
    f_at_u_0(i)= x_traj(i);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dx_dot/du
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1: num_inputs
    
    delta_u = zeros(num_inputs,1);
    delta_u(i) = 1;
    
    % Run the model in the true coordinate frame.
    x_traj = eval( strcat(model_file, '(t(epoch), x(epoch,:), delta_u )' ));
    for j=1: num_states
        x_plus_delta_answer(j) = x_traj(j);
    
        dx_dot_du(i,j) = (x_plus_delta_answer(j)-f_at_u_0(j))/delta_u(i);
    end
end

