function dx = plant_13(t,x)

global num_states num_inputs

% dx: Returns the time derivatives of the state variables, x-dot.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate the control effort variables to make it easier for the user
% to type in the equations

u = x(num_states+1 : num_states+num_inputs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the system here:

% Third order - Power system transient stability
dx = [ x(2);
     1-x(3)*sin(x(1))+0.5*sin(x(1))*cos(x(1));
     1-0.5*x(3)+cos(x(1))+u(1)];


% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+i,:)= zeros(size(x(2,:)));
end