function dx = planar_robot_model(t,x,u)


global num_inputs num_states

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Do not modify anything in this top section.

% Needs to return a (num_states + num_inputs) vector since the input is
% (num_states + num_inputs)-long.
% The final entries in the returned vector are meaningless.

% Pad the end of the vector to the right size.
for i=num_states+1 : num_states+num_inputs
    dx(i) = 0;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L1 = 1;
L2 = 0.5;

f = -L1^4+2*L1^2*L2^2+2*L1^2*x(2)^2+2*L1^2*x(2)^2-L2^4+2*L2^2*x(2)^2+2*L2^2*x(2)^2-x(1)^4-2*x(1)^2*x(2)^2-x(2)^4;
g = L1^2+2*L1*x(1)-L2^2+x(1)^2+x(2)^2;

m = L1^2-2*L1*L2+L2^2-x(1)^2-x(2)^2;

theta1 = 2*atan( (2*L1-f^0.5)/g ) + pi;
theta2 = 2*( pi - atan(f^0.5/m) );

dx(1) = -L1*sin(theta1)*u(1)-L2*(cos(theta1)*sin(theta2)+sin(theta1)*cos(theta2))*(u(1)+u(2));
dx(2) = L1*cos(theta1)*u(1)+L2*(cos(theta1)*cos(theta2)-sin(theta1)*sin(theta2))*(u(1)+u(2));