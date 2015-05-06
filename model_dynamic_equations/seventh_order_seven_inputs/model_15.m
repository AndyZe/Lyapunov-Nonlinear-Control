function dx = model_15(t,x,u)


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

% Control seven different motors
% theta_double_dot(i) = (1/J)*(K*u(i)-b*theta_dot(i))
% x: theta_dot
% J: rotor moment of inertia
% b: friction constant
% K: back emf constant

% I varied J,K, and b together. 1 for x1, 2 for x2,...
% To add some uncertainty to the friction constant: *rand()
dx(1) = (1/1)*(1*u(1)-1*x(1)); % theta_double_dot(1) = (1/1)*(1*u1-1*theta_dot(1))
dx(2) = (1/2)*(2*u(2)-2*x(2));
dx(3) = (1/3)*(3*u(3)-3*x(3));
dx(4) = (1/4)*(4*u(4)-4*x(4));
dx(5) = (1/5)*(5*u(5)-5*x(5));
dx(6) = (1/6)*(6*u(6)-6*x(6));
dx(7) = (1/7)*(7*u(7)-7*x(7));