function dx = sec_order_ZN_PID_comparison_plant(t,x)

global num_states num_inputs

% dx: Returns the time derivatives of the state variables, x-dot.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate the control effort variables to make it easier for the user
% to type in the equations

x1 = x(1,:);
x2 = x(2,:);
u1 = x(3,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the system here:

dx = [ 1000000*x2;
 (1/2)*(-4*x2-.000003*x1+u1)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Append zeros for the inputs so vector lengths match
for i=1:num_inputs
   dx(num_states+i,:)= zeros(size(x(2,:)));
end