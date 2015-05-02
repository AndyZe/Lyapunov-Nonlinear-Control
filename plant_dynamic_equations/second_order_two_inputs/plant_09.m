function dx = plant_09(t,x)

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

% Wong, 1998
% car-pole inverted pendulum
dx = [ x(2,:)+x(4,:);
    (9.8*sin(x(1,:))-0.025*x(2,:).^2*sin(2*x(1,:))-0.1*cos(x(1,:))*x(3,:))/...
    ( (2/3)-0.1*cos(x(1,:)).^2)];

% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+i,:)= zeros(size(x(2,:)));
end
