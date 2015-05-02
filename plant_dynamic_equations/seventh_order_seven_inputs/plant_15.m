function dx = plant_15(t,x)

global num_states num_inputs

% dx: Returns the time derivatives of the state variables,
% x-dot.
% There are some meaningless zeros padded on the end of the returned vector
% to make vector lengths match.

% x: input vector, [x u]
% Total length is num_states+num_inputs
% For example, for 2 states & 2 inputs:
% x1 is x(1,:)
% x2 is x(2,:)
% u1 is x(3,:)
% u2 is x(4,:)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% State-space definition of the system.
% These are vectorized for speed,
% i.e. MATLAB can try many values simultaneously.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Control seven different motors
% theta_double_dot(i) = (1/J)*(K*u(i)-b*theta_dot(i))
% x: theta_dot
% J: rotor moment of inertia
% b: friction constant
% K: back emf constant

% I varied J,K, and b together. 1 for x1, 2 for x2,...
% The corresponding model has some uncertainty.

dx = [ (1/1)*(1*x(8,:)-1*x(1,:));
        (1/2)*(2*x(9,:)-2*x(2,:));
        (1/3)*(3*x(10,:)-3*x(3,:));
        (1/4)*(4*x(11,:)-4*x(4,:));
        (1/5)*(5*x(12,:)-5*x(5,:));
        (1/6)*(6*x(13,:)-6*x(6,:));
        (1/7)*(7*x(14,:)-7*x(7,:));
];

% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+i,:)= zeros(size(x(2,:)));
end