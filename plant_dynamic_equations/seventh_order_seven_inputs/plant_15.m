function dx = plant_15(t,x)

global num_states num_inputs

% dx: Returns the time derivatives of the state variables, x-dot.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate the control effort variables to make it easier for the user
% to type in the equations

x1 = x(1,:);
x2 = x(2,:);
x3 = x(3,:);
x4 = x(4,:);
x5 = x(5,:);
x6 = x(6,:);
x7 = x(7,:);

u1 = x(8,:);
u2 = x(9,:);
u3 = x(10,:);
u4 = x(11,:);
u5 = x(12,:);
u6 = x(13,:);
u7 = x(14,:);

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

dx = [ (1/1)*(u1-1*x1);
        (1/2)*(u2-4*x2);
        (1/3)*(u3-9*x3);
        (1/4)*(u4-16*x4);
        (1/5)*(u5-25*x5);
        (1/6)*(u6-36*x6);
        (1/7)*(u7-49*x7);
];

% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+i,:)= zeros(size(x(2,:)));
end