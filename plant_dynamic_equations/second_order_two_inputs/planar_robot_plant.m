function dx = planar_robot_plant(t,x)

global num_states num_inputs

% dx: Returns the time derivatives of the state variables, x-dot.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate the control effort variables to make it easier for the user
% to type in the equations

x1 = x(1,:);
x2 = x(2,:);
u1 = x(3,:);
u2 = x(4,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the system here:

L1 = 1;
L2 = 0.5;

f = -L1^4+2*L1^2*L2^2+2*L1^2*x2^2+2*L1^2*x2^2-L2^4+2*L2^2*x2^2+2*L2^2*x2^2-x1^4-2*x1^2*x2^2-x2^4;
g = L1^2+2*L1*x1-L2^2+x1^2+x2^2;

m = L1^2-2*L1*L2+L2^2-x1^2-x2^2;

theta1 = 2*atan( (2*L1-f^0.5)/g ) + pi;
theta2 = 2*( pi - atan(f^0.5/m) );

dx = [ -L1*sin(theta1)*u1-L2*(cos(theta1)*sin(theta2)+sin(theta1)*cos(theta2))*(u1+u2);
    L1*cos(theta1)*u1+L2*(cos(theta1)*cos(theta2)-sin(theta1)*sin(theta2))*(u1+u2)];

% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+i,:)= zeros(size(x(2,:)));
end