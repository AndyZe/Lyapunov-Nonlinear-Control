function dx = model_swerve_steer(t,x,u)


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
W=1.0;
L=1.0;
% Third order
dx(1) = (W/2)*sin(x(3))*u(1)-(L/2)*cos(x(3))*u(1)+u(2); % Emphasize the first state
dx(2) = -(W/2)*cos(x(3))*u(1)-(L/2)*sin(x(3))*u(1)+u(3);
dx(3) = u(1);