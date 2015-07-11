function dx = model_bishop_rel_vel(t,x,u)


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

% Third order
dx(1) = 100*x(2); % Emphasize the first state
dx(2) = x(3);
dx(3) = -10*x(2)-(16/100)*x(1)+u;