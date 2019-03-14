function dx = plant_swerve_steer(t,x)

global num_states num_inputs

% dx: Returns the time derivatives of the state variables, x-dot.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate the control effort variables to make it easier for the user
% to type in the equations

x1 = x(1,:);
x2 = x(2,:);
x3 = x(3,:);

u1 = x(4,:);
u2 = x(5,:);
u3 = x(6,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the system here:
W=1.0;
L=1.0;
% Third order - column vector
dx = [(W/2)*sin(x3)*u1-(L/2)*cos(x3)*u1+u2; 
    -(W/2)*cos(x3)*u1-(L/2)*sin(x3)*u1+u3;
    u1;];

% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+i,:)= zeros(size(x(2,:)));
end