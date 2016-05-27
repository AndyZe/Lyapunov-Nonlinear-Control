function dx = triple_integrator_model(t,x,u)


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

% Slotine, page 216
dx(1) = sin(x(2))+(x(2)+1)*x(3);    % x1_dot
dx(2) = x(1)^5+x(3);                % x2_dot
dx(3) = x(1)^2+u;                   % x3_dot
dx(4) = dx(1);                      % y_dot = x1_dot