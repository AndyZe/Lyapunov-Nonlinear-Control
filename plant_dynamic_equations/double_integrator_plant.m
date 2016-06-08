function dx = triple_integrator_plant(t,x)

global num_states num_inputs

% dx: Returns the time derivatives of the state variables, x-dot.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate the control effort variables to make it easier for the user
% to type in the equations

x1 = x(1,:);
x2 = x(2,:);
x3 = x(3,:);
y1 = x(4,:);
u1 = x(5,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the system here:
dx = [ x2+x3;                  % x1_dot
 x3;                     % x2_dot
 u1;                         % x3_dot
 x2+x3];                        % y_dot = x1_dot = x2+x3

% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+1+i,:)= zeros(size(x(2,:)));
end