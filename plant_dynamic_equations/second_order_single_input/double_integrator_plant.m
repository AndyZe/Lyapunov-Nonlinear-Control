function dx = double_integrator_plant(t,x)

global num_states num_inputs

% dx: Returns the time derivatives of the state variables, x-dot.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate the control effort variables to make it easier for the user
% to type in the equations

x1 = x(1,:);
x2 = x(2,:);
y1 = x(3,:);
u1 = x(4,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the system here:
% Khalil, page 542

dx = [ x2;                  % x1_dot
 -x1+(1-x1^2)*x2+u1;        % x2_dot
 -x1+(1-x1^2)*x2+u1];       % y_dot = x2_dot

% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+1+i,:)= zeros(size(x(2,:)));
end