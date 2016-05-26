
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY these variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Previously defined from user input
global num_inputs num_states x_IC y_IC start_time stop_time delta_t

% Preallocate
global max_sim_epochs
max_sim_epochs = round(10+(stop_time-start_time)/delta_t);

global epoch % What epoch are we on?
epoch=1;

global x % Current coordinates of the state variables
x=zeros(max_sim_epochs,num_states); % Preallocate

% Initialize the first two rows to ICs
for i=1:num_states
    x(1,i)=x_IC(i);
    x(2,i)=x_IC(i);
end

global y % Current coordinates of the state variables
y=zeros(max_sim_epochs,1); % Preallocate

% Initialize the first two rows to ICs
y(1) = y_IC;
y(2) = y_IC;

global t
t=zeros(max_sim_epochs,1); % Preallocate
t(1)= start_time;

% Log of Lyapunov function switches
global using_V1 using_V2 using_V3
using_V1=NaN(max_sim_epochs);
using_V2=NaN(max_sim_epochs);
using_V3=NaN(max_sim_epochs);

global u        % Control effort
u=zeros(max_sim_epochs,num_inputs);

global filtered_u % Filtered control effort
filtered_u = zeros(max_sim_epochs, num_inputs);

global V  % Store Lyapunov values
V=zeros(max_sim_epochs,1);
V(1)=0;
for i=1:num_states
    V(1)=V(1)+0.5*x(i)^2;
end

global dx_dot_du % Partial derivatives of the state variables w.r.t.
                    % the control efforts (a Jacobian)
dx_dot_du = zeros(num_inputs,num_states);
                    
global V_dot_target V_dot_target_initial
% Target damping on the Lyapunov value
% Will decrease as we get closer to origin
V_dot_target = V_dot_target_initial;

% The history of targets
global target_history
target_history = NaN(max_sim_epochs,num_states);

