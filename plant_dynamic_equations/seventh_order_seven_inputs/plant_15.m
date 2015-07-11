function dx = plant_15(t,x)

global num_states num_inputs

% dx: Returns the time derivatives of the state variables, x-dot.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate the control effort variables to make it easier for the user
% to type in the equations

u = x(num_states+1 : num_states+num_inputs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the system here:

% Control seven different motors
% theta_double_dot(i) = (1/J)*(K*u(i)-b*theta_dot(i))
% x: theta_dot
% J: rotor moment of inertia
% b: friction constant
% K: back emf constant

% I varied J,K, and b together. 1 for x1, 2 for x2,...
% The corresponding model has some uncertainty.

dx = [ (1/1)*(1*u(1)-1*x(1));
        (1/2)*(2*u(2)-2*x(2));
        (1/3)*(3*u(3)-3*x(3));
        (1/4)*(4*u(4)-4*x(4));
        (1/5)*(5*u(5)-5*x(5));
        (1/6)*(6*u(6)-6*x(6));
        (1/7)*(7*u(7)-7*x(7));
];

% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+i,:)= zeros(size(x(2,:)));
end