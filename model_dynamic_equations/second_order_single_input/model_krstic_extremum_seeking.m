function dx = model_krstic_extremum_seeking(t,x,u)


global num_inputs num_states

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dx: Returns the time derivatives of the state variables, x-dot.

% Do not modify anything in this top section.

% Needs to return a (num_states + num_inputs) vector since the input is
% (num_states + num_inputs)-long.
% The final entries in the returned vector are meaningless.

% Pad the end of the vector to the right size.
for i=num_states+1 : num_states+num_inputs
    dx(i) = 0;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the system here:

dx(1) = 1000*x(2);
dx(2) = (u-x(1)/1000-1.6*x(2))/0.6;
