function dx = double_integrator_model(t,x,u)


global num_inputs num_states

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Do not modify anything in this top section.

% Needs to return a (num_states + num_inputs) vector since the input is
% (num_states + num_inputs)-long.
% The final entries in the returned vector are meaningless.

% Pad the end of the vector to the right size.
for i=num_states+1+1 : num_states+num_inputs
    dx(i) = 0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Khalil, page 542
dx(1) = -x(2);                      % x1_dot
dx(2) = -x(1)+(1-x(1)^2)*x(2)+u;    % x2_dot
dx(3) = -x(1)+(1-x(1)^2)*x(2)+u;    % y_dot = x2_dot