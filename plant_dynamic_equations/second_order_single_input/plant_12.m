function dx = plant_12(t,x)

global num_states num_inputs

% dx: Returns the time derivatives of the state variables, x-dot.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate the control effort variables to make it easier for the user
% to type in the equations

u = x(num_states+1 : num_states+num_inputs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the system here:

% Lotka-Volterra Predator-Prey Model
% Uncontrollable?
dx = [x(1).*(1.5-x(2));
    -x(2).*(3-x(1))+u];


% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+i,:)= zeros(size(x(2,:)));
end