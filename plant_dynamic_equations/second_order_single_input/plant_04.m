function dx = plant_04(t,x)

global num_states num_inputs

% dx: Returns the time derivatives of the state variables, x-dot.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate the control effort variables to make it easier for the user
% to type in the equations

u = x(num_states+1 : num_states+num_inputs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the system here:

% Adaptation helps with this one
dx = [ x(2);
 0.1*x(2)-x(1)^3-u];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+i,:)= zeros(size(x(2,:)));
end