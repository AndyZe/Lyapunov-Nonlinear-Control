function dx = plant_09(t,x)

global num_states num_inputs

% dx: Returns the time derivatives of the state variables, x-dot.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate the control effort variables to make it easier for the user
% to type in the equations

u = x(num_states+1 : num_states+num_inputs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the system here:

% Wong, 1998
% car-pole inverted pendulum
dx = [ x(2)+u(2);
    (9.8*sin(x(1))-0.025*x(2)^2*sin(2*x(1))-0.1*cos(x(1))*u(1))/...
    ( (2/3)-0.1*cos(x(1))^2)];

% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+i,:)= zeros(size(x(2,:)));
end
